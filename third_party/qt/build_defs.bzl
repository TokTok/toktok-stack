"""Starlark rules and macros to support Qt6 compilation.

This file defines three macros:
- qt_uic, compiles .ui files into header files.
- qt_lconvert, compiles .ts files into .qm files.
- qt_rcc, compiles .res files into a cc_library.
- qt_moc, generates .cpp or .moc files for Qt MOC .h or .cpp files.
"""

# Qt UI compiler rule.
# =========================================================

load("@build_bazel_rules_apple//apple:macos.bzl", "macos_application")
load("@rules_cc//cc:defs.bzl", "cc_library", "cc_test")

def _qt_uic_impl(ctx):
    uic = ctx.executable._uic

    srcs = [src for tgt in ctx.attr.srcs for src in tgt.files.to_list()]
    outs = []

    for src in srcs:
        basename = src.basename[:-3]
        hdr = ctx.actions.declare_file("ui_%s.h" % basename)
        outs.append(hdr)
        ctx.actions.run(
            arguments = [
                src.path,
                "-o",
                hdr.path,
            ],
            executable = uic.path,
            inputs = [src],
            mnemonic = "CompileUIC",
            outputs = [hdr],
            progress_message = "Generating Qt UI header for " + src.basename,
            tools = [uic],
        )

    return DefaultInfo(files = depset(outs))

qt_uic = rule(
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".ui"],
            doc = "The .ui files to compile.",
        ),
        "_uic": attr.label(
            default = Label("@qt//:uic"),
            executable = True,
            cfg = "exec",
            allow_single_file = True,
        ),
    },
    output_to_genfiles = True,
    implementation = _qt_uic_impl,
)

# Qt language translation compiler rule.
# =========================================================

def _qt_lconvert_impl(ctx):
    lconvert = ctx.executable._lconvert

    srcs = [src for tgt in ctx.attr.srcs for src in tgt.files.to_list()]
    outs = []

    for src in srcs:
        basename = src.basename[:-3]
        qm = ctx.actions.declare_file("%s.qm" % basename, sibling = src)
        outs.append(qm)
        ctx.actions.run(
            arguments = [
                src.path,
                "-of",
                "qm",
                "-o",
                qm.path,
            ],
            executable = lconvert.path,
            inputs = [src],
            mnemonic = "CompileLConvert",
            outputs = [qm],
            progress_message = "Generating Qt binary translation file for " + src.basename,
            tools = [lconvert],
        )

    return DefaultInfo(files = depset(outs))

qt_lconvert = rule(
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".ts"],
            doc = "The .ts files to compile.",
        ),
        "_lconvert": attr.label(
            default = Label("@qt//:lconvert"),
            executable = True,
            cfg = "exec",
            allow_single_file = True,
        ),
    },
    output_to_genfiles = True,
    implementation = _qt_lconvert_impl,
)

# Qt resource compiler rule.
# =========================================================

def _qt_rcc_impl(ctx):
    rcc = ctx.executable._rcc

    srcs = [src for tgt in ctx.attr.srcs for src in tgt.files.to_list()]
    data = [dat for tgt in ctx.attr.data for dat in tgt.files.to_list()]

    rcc_cpp = ctx.actions.declare_file("rcc_%s.cpp" % ctx.attr.name)

    ctx.actions.run(
        arguments = [src.path for src in srcs] + [
            "--name",
            ctx.attr.name,
            "--compress",
            "9",
            "--threshold",
            "50",
            "-o",
            rcc_cpp.path,
        ],
        executable = rcc.path,
        inputs = srcs + data,
        mnemonic = "CompileRCC",
        outputs = [rcc_cpp],
        progress_message = "Generating Qt resource file " + rcc_cpp.path,
        tools = [rcc],
    )

    return DefaultInfo(files = depset([rcc_cpp]))

qt_rcc = rule(
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".qrc"],
            doc = "The .qrc resource xml files to compile.",
        ),
        "data": attr.label_list(
            allow_files = True,
            doc = "The resource files to compile into the resulting .cpp file.",
        ),
        "_rcc": attr.label(
            default = Label("@qt//:rcc"),
            executable = True,
            cfg = "exec",
            allow_single_file = True,
        ),
    },
    output_to_genfiles = True,
    implementation = _qt_rcc_impl,
)

# Qt MOC compiler rule.
# =========================================================

def _qt_moc_impl(ctx):
    # The moc binary path.
    moc = ctx.executable._moc

    # Find all "includes = [...]" for the deps and add them to the -I include
    # list in the moc argument list.
    includes = {
        "-I%s" % inc: None
        for dep in ctx.attr.deps
        if CcInfo in dep
        for inc in dep[CcInfo].compilation_context.system_includes.to_list()
    }.keys()

    srcs = [
        src
        for tgt in ctx.attr.srcs
        for src in tgt.files.to_list()
    ]
    hdrs = [
        hdr
        for tgt in ctx.attr.hdrs
        for hdr in tgt.files.to_list()
    ]
    deps = [
        hdr
        for tgt in ctx.attr.deps
        if CcInfo in tgt
        for hdr in tgt[CcInfo].compilation_context.headers.to_list()
    ]
    outs = []

    for src in srcs:
        if src.extension == "h":
            out = ctx.actions.declare_file(
                "moc_%s.cpp" % src.basename[:-2],
                sibling = src,
            )
        else:
            out = ctx.actions.declare_file(
                "%s.moc" % src.basename[:-4],
                sibling = src,
            )
        outs.append(out)

        arguments = []
        arguments.extend(includes)

        # Add the user-specified flags.
        arguments.extend(ctx.attr.mocopts)

        # If we're compiling for a .h file, we #include it in the resulting
        # moc_$name.cpp.
        if src.path[src.path.rindex("."):] == ".h":
            arguments.append("-f" + src.path)

        # moc $src -o $out
        arguments.extend([src.path, "-o", out.path])

        for k, v in ctx.attr.metadata.items():
            arguments.extend(["-M%s=%s" % (k, v)])

        # Inputs: the primary source file.
        inputs = [src]

        # Make sure all files listed as hdrs are in the execution environment.
        inputs.extend(hdrs)

        # Also add all transitive headers from deps to the environment.
        inputs.extend(deps)

        # Execute moc.
        ctx.actions.run(
            arguments = arguments,
            executable = moc.path,
            inputs = inputs,
            mnemonic = "CompileMoc",
            outputs = [out],
            progress_message = "Generating Qt MOC source for " + src.basename,
            tools = [moc],
        )

    return DefaultInfo(files = depset(outs))

qt_moc = rule(
    attrs = {
        "srcs": attr.label_list(allow_files = [
            ".cpp",
            ".h",
        ]),
        "hdrs": attr.label_list(allow_files = [".h"]),
        "metadata": attr.string_dict(),
        "out": attr.output(),
        "deps": attr.label_list(),
        "mocopts": attr.string_list(),
        "_moc": attr.label(
            default = Label("@qt//:moc"),
            executable = True,
            cfg = "exec",
            allow_single_file = True,
        ),
    },
    output_to_genfiles = True,
    implementation = _qt_moc_impl,
)

# Qt test with MOC for the test .cpp file.
# =========================================================

def qt_test(name, src, deps, copts = [], mocopts = [], size = None, **kwargs):
    qt_moc(
        name = "%s_moc_src" % name,
        testonly = True,
        srcs = [src],
        mocopts = mocopts,
        tags = ["no-cross"],
        deps = deps,
    )
    cc_library(
        name = "%s_moc" % name,
        testonly = True,
        hdrs = [":%s_moc_src" % name],
        tags = ["no-cross"],
        **kwargs
    )
    cc_test(
        name = name,
        size = size,
        srcs = [src],
        copts = copts + ["-I$(GENDIR)/%s/%s" % (
            native.package_name(),
            src[:src.rindex("/")],
        )],
        env = {
            "QT_PLUGIN_PATH": "external/qt6.qtbase/lib/qt-6/plugins",
            "QT_QPA_PLATFORM": "offscreen",
        },
        data = [
            "@openssl.out//:lib",
            "@qt//:qt_platform",
        ],
        deps = deps + [
            ":%s_moc" % name,
            "@qt//:qt_test",
        ],
        tags = ["no-cross"],
        **kwargs
    )

# Building app bundles for macOS.
# =========================================================

def qt_mac_deploy(name, app_icons, bundle_id, deps):
    macos_application(
        name = name,
        app_icons = app_icons,
        bundle_id = bundle_id,
        infoplists = [":info.plist"],
        # 10.9 is the lowest we can go and still get libstdc++.
        minimum_os_version = "10.9",
        tags = ["manual"],
        deps = deps,
    )

    app = name + ".app"
    native.genrule(
        name = name + "_deploy",
        srcs = [":" + name],
        outs = [name + "_deploy.tar.gz"],
        cmd = "\n".join([
            "unzip -q $<",
            "$(location @qt//:macdeployqt) " + app,
            "$(location //third_party/qt:deduplicate) " + app,
            "$(location //third_party/qt:macfixrpath) " + app,
            "tar zcf $@ " + app,
        ]),
        tags = ["manual"],
        tools = [
            "//third_party/qt:deduplicate",
            "//third_party/qt:macfixrpath",
            "@qt//:macdeployqt",
        ],
    )

def qt_win_deploy(name, deps):
    native.genrule(
        name = name + "_deploy",
        srcs = deps,
        outs = [
            name + ".tar.gz",
            "windeployqt.log",
        ],
        cmd = " ".join([
            "mkdir -p $$$$/{name};".format(name = name),
            "cp $(location //{name}) $$$$/{name}/;".format(name = name),
            "cp `dirname $(location //{name})`/{name}.pdb $$$$/{name}/;".format(name = name),
            "$(location @qt//:windeployqt) $$$$/{name} > $(location windeployqt.log);".format(name = name),
            "tar zcf $(location {name}.tar.gz) --strip-components=1 $$$$/{name}".format(name = name),
        ]),
        tags = ["manual"],
        exec_tools = ["@qt//:windeployqt"],
    )

    native.sh_binary(
        name = name,
        srcs = ["//third_party/qt:winlaunch.sh"],
        args = [name, "$(location %s.tar.gz)" % name],
        data = ["%s.tar.gz" % name],
        tags = ["manual"],
    )
