"""Skylark rules and macros to support Qt5 compilation.

This file defines three macros:
- qt_uic, compiles .ui files into header files.
- qt_rcc, compiles .res files into a cc_library.
- qt_moc, generates .cpp or .moc files for Qt MOC .h or .cpp files.
"""

# Qt UI compiler rule.
# =========================================================

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
            default = Label("@qt//:bin/uic"),
            executable = True,
            cfg = "host",
            allow_single_file = True,
        ),
    },
    output_to_genfiles = True,
    implementation = _qt_uic_impl,
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
            default = Label("@qt//:bin/rcc"),
            executable = True,
            cfg = "host",
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
        if hasattr(dep, "cc")
        for inc in dep.cc.system_include_directories
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
        if hasattr(tgt, "cc")
        for hdr in tgt.cc.transitive_headers.to_list()
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

        # Inputs: the primary source file.
        inputs = [src]

        # Make sure all files listed as srcs are in the execution environment.
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
        "out": attr.output(),
        "deps": attr.label_list(),
        "mocopts": attr.string_list(),
        "_moc": attr.label(
            default = Label("@qt//:bin/moc"),
            executable = True,
            cfg = "host",
            allow_single_file = True,
        ),
    },
    output_to_genfiles = True,
    implementation = _qt_moc_impl,
)

# Qt test with MOC for the test .cpp file.
# =========================================================

def qt_test(name, src, deps, copts=[]):
    qt_moc(
        name = "%s_moc_src" % name,
        srcs = [src],
    )

    native.cc_library(
        name = "%s_moc" % name,
        hdrs = [":%s_moc_src" % name],
    )

    native.cc_test(
        name = name,
        srcs = [src],
        copts = copts + ["-I$(GENDIR)/%s/%s" % (native.package_name(), src[:src.rindex("/")])],
        deps = deps + [
            ":%s_moc" % name,
            "@qt//:qt_test",
        ],
    )

# Qt library import into cc_libraries.
# =========================================================

def qt_import(name, module):
    native.objc_framework(
        name = "Qt%s_framework" % module,
        framework_imports = native.glob(["Frameworks/Qt%s.framework/**" % module]),
    )

    native.objc_library(
        name = "Qt%s_osx" % module,
        deps = ["Qt%s_framework" % module],
    )

    native.cc_library(
        name = "Qt%s_elf" % module,
        srcs = [
            "lib/libQt5%s.so.5" % module,
            "lib/libQt5%s.so" % module,
        ],
        linkopts = [
            "-Wl,-rpath,external/qt/lib",
            "-Lexternal/qt/lib",
            "-lQt5%s" % module,
        ],
    )

    native.cc_library(
        name = name,
        hdrs = native.glob(["include/Qt%s/**" % module]),
        includes = [
            "include",
            "include/Qt%s" % module,
        ],
        linkopts = select({
            "@toktok//tools/config:linux": [],
            "@toktok//tools/config:osx": [
                "-F/usr/local/opt/qt/Frameworks",
                "-framework Qt%s" % module,
            ],
        }),
        visibility = ["//visibility:public"],
        deps = select({
            "@toktok//tools/config:linux": [":Qt%s_elf" % module],
            "@toktok//tools/config:osx": [":Qt%s_osx" % module],
        }),
    )
