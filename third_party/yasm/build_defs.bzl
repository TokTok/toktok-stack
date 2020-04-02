"""Skylark build rule for assembly code to be assembled by yasm."""

load("@rules_cc//cc:action_names.bzl", "CPP_LINK_STATIC_LIBRARY_ACTION_NAME")
load("@rules_cc//cc:toolchain_utils.bzl", "find_cpp_toolchain")

def _c_archive_impl(ctx, objs):
    cc_toolchain = find_cpp_toolchain(ctx)
    output_file = ctx.actions.declare_file(ctx.label.name + ".a")

    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )

    library_to_link = cc_common.create_library_to_link(
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        static_library = output_file,
    )
    compilation_context = cc_common.create_compilation_context()
    linking_context = cc_common.create_linking_context(libraries_to_link = [library_to_link])

    archiver_path = cc_common.get_tool_for_action(
        feature_configuration = feature_configuration,
        action_name = CPP_LINK_STATIC_LIBRARY_ACTION_NAME,
    )
    archiver_variables = cc_common.create_link_variables(
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        output_file = output_file.path,
        is_using_linker = False,
    )
    command_line = cc_common.get_memory_inefficient_command_line(
        feature_configuration = feature_configuration,
        action_name = CPP_LINK_STATIC_LIBRARY_ACTION_NAME,
        variables = archiver_variables,
    )
    args = ctx.actions.args()
    args.add_all(command_line)
    args.add_all(objs)

    env = cc_common.get_environment_variables(
        feature_configuration = feature_configuration,
        action_name = CPP_LINK_STATIC_LIBRARY_ACTION_NAME,
        variables = archiver_variables,
    )

    ctx.actions.run(
        executable = archiver_path,
        arguments = [args],
        env = env,
        inputs = depset(
            direct = objs,
            transitive = [
                cc_toolchain.all_files,
            ],
        ),
        outputs = [output_file],
    )

    return [CcInfo(compilation_context = compilation_context, linking_context = linking_context)]

def _asm_library_impl(ctx):
    yasm = ctx.executable._yasm

    hdrs = [hdr for lbl in ctx.attr.hdrs for hdr in lbl.files.to_list()]
    srcs = [src for lbl in ctx.attr.srcs for src in lbl.files.to_list()]

    asmopts = [ctx.expand_make_variables("cmd", opt, {}) for opt in ctx.attr.asmopts]

    outs = []
    for src in srcs:
        out = ctx.actions.declare_file(src.path[:-4] + ".obj")
        outs.append(out)
        ctx.actions.run(
            arguments = asmopts + [
                ctx.attr.execfmt,
                "-o",
                out.path,
                src.path,
            ],
            executable = yasm.path,
            inputs = hdrs + [src],
            mnemonic = "Assemble",
            outputs = [out],
            progress_message = "Assembling " + src.path,
            tools = [yasm],
        )

    if ctx.attr.archive:
        return _c_archive_impl(ctx, outs)
    else:
        return [DefaultInfo(files = depset(outs))]

_asm_library = rule(
    attrs = {
        "srcs": attr.label_list(allow_files = [".asm"]),
        "hdrs": attr.label_list(allow_files = [".asm"]),
        "asmopts": attr.string_list(),
        "execfmt": attr.string(),
        "archive": attr.bool(default = True),
        "_yasm": attr.label(
            default = Label("@yasm"),
            executable = True,
            cfg = "host",
            allow_single_file = True,
        ),
        "_cc_toolchain": attr.label(default = Label("@rules_cc//cc:current_cc_toolchain")),
    },
    fragments = ["cpp"],
    implementation = _asm_library_impl,
    toolchains = ["@rules_cc//cc:toolchain_type"],
)

def asm_library(**kwargs):
    _asm_library(
        execfmt = select({
            "@toktok//tools/config:freebsd": "-felf64",
            "@toktok//tools/config:linux": "-felf64",
            "@toktok//tools/config:osx": "-fmacho64",
            "@toktok//tools/config:windows": "-fwin64",
        }),
        **kwargs
    )
