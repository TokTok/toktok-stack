"""Haskell c2hs FFI generator."""

load("@rules_cc//cc:defs.bzl", "CcInfo", "cc_common")
load("@rules_cc//cc:find_cc_toolchain.bzl", "find_cpp_toolchain")

def _c2hs_library_impl(ctx):
    src = ctx.file.src
    hs_out = ctx.actions.declare_file(src.basename[:-4] + ".hs", sibling = src)
    c_out = ctx.actions.declare_file(src.basename[:-4] + "_c.c", sibling = src)
    h_out = ctx.actions.declare_file(src.basename + ".h", sibling = src)

    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )

    # Collect headers and includes from deps
    compilation_contexts = [dep[CcInfo].compilation_context for dep in ctx.attr.deps]

    headers = depset(transitive = [cc.headers for cc in compilation_contexts])

    # Simple approach: construct include flags for c2hs
    include_flags = []
    for cc in compilation_contexts:
        for inc in cc.includes.to_list():
             include_flags.append("-I" + inc)
        for inc in cc.quote_includes.to_list():
             include_flags.append("-I" + inc)
        for inc in cc.system_includes.to_list():
             include_flags.append("-isystem" + inc)

    # User copts
    user_copts = ctx.attr.copts

    # The c2hs binary
    c2hs_tool = ctx.executable._c2hs

    args = ctx.actions.args()
    args.add("--cpp=" + cc_toolchain.compiler_executable)
    args.add("--cppopts=-E") # Preprocess only

    # Pass include flags and copts as cppopts
    for f in include_flags + user_copts:
        args.add("--cppopts=" + f)

    args.add("-o", hs_out)
    args.add(src)

    expected_c = hs_out.path[:-3] + ".chs.c"

    ctx.actions.run_shell(
        outputs = [hs_out, c_out, h_out],
        inputs = depset([src], transitive=[headers]),
        tools = [c2hs_tool],
        command = """
            "$1" "${@:2}"
            if [ -f "%s" ]; then
                mv "%s" "%s"
                sed -i 's|#include ".*/|#include "|' "%s"
            else
                echo "Expected C file %s not found. Listing directory of output:"
                ls -la "$(dirname "%s")"
                touch "%s"
            fi
            if [ ! -f "%s" ]; then
                touch "%s"
            fi
        """ % (expected_c, expected_c, c_out.path, c_out.path, expected_c, hs_out.path, c_out.path, h_out.path, h_out.path),
        arguments = [c2hs_tool.path, args],
        mnemonic = "C2hs",
        progress_message = "Generating Haskell bindings for %s" % src.short_path,
        env = {
        }
    )

    # Compile the C file
    (compilation_context, compilation_outputs) = cc_common.compile(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        srcs = [c_out],
        public_hdrs = [h_out],
        compilation_contexts = compilation_contexts,
    )

    linking_contexts = [dep[CcInfo].linking_context for dep in ctx.attr.deps]

    (linking_context, linking_outputs) = cc_common.create_linking_context_from_compilation_outputs(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        compilation_outputs = compilation_outputs,
        linking_contexts = linking_contexts,
    )

    cc_info = CcInfo(
        compilation_context = compilation_context,
        linking_context = linking_context,
    )

    return [
        DefaultInfo(files = depset([hs_out])),
        OutputGroupInfo(
            hs = depset([hs_out]),
            c = depset([c_out]),
            h = depset([h_out]),
        ),
        cc_info,
    ]

c2hs_library = rule(
    implementation = _c2hs_library_impl,
    attrs = {
        "src": attr.label(allow_single_file = [".chs"], mandatory = True),
        "deps": attr.label_list(providers = [CcInfo]),
        "copts": attr.string_list(),
        "_c2hs": attr.label(
            default = Label("//third_party/haskell/c2hs:c2hs"),
            executable = True,
            cfg = "exec",
        ),
        "_cc_toolchain": attr.label(default = Label("@bazel_tools//tools/cpp:current_cc_toolchain")),
    },
    toolchains = ["@bazel_tools//tools/cpp:toolchain_type"],
    fragments = ["cpp"],
)
