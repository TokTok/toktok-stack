"""Skylark rules and macros to support Qt5 compilation.

This file defines three macros:
- qt_ui_library, compiles .ui files into a cc_library
- qt_rcc, compiles .res files into a cc_library
- qt_moc, generates .cpp or .moc files for Qt MOC .h or .cpp files.
"""

# Qt UI compiler rule.
# =========================================================

def qt_ui_library(name, ui, deps=None):
  """Compiles a QT UI file and makes a library for it.

  Args:
    name: A name for the rule.
    ui: The ui file to compile.
    deps: cc_library dependencies for the library.
  """
  native.genrule(
      name = "%s_uic" % name,
      srcs = [
          ui,
          "@qt//:bin/uic",
      ],
      outs = ["ui_%s.h" % ui.rsplit("/", 1)[1].split(".")[0]],
      cmd = "$(location @qt//:bin/uic) $(locations %s) -o $@" % ui,
  )

  native.cc_library(
      name = name,
      hdrs = [":%s_uic" % name],
      deps = deps,
  )

# Qt resource compiler rule.
# =========================================================

def qt_rcc(name, srcs, data):
  native.genrule(
      name = "%s_rcc" % name,
      srcs = srcs + data + ["@qt//:bin/rcc"],
      outs = ["rcc_%s.cpp" % name],
      cmd = "$(location @qt//:bin/rcc) {} -o $@".format(" ".join(["$(location %s)" % src for src in srcs])),
  )

  native.cc_library(
      name = name,
      srcs = [":%s_rcc" % name],
      deps = ["@qt//:qt_core"],
      alwayslink = True,
  )

# Qt MOC compiler rule.
# =========================================================

def _qt_moc_impl(ctx):
  # The moc binary path.
  moc = ctx.executable._moc

  # The main source file to pass to moc.
  src = ctx.attr.src.files.to_list()[0]
  # The output file: moc_$name.cpp or $name.moc, coming from qt_moc() below.
  out = ctx.actions.declare_file(ctx.attr.out.name)

  # Find all "includes = [...]" for the deps and add them to the -I include
  # list in the moc argument list.
  arguments = {
      "-I%s" % inc: None
      for dep in ctx.attr.deps if hasattr(dep, "cc")
      for inc in dep.cc.system_include_directories
  }.keys()

  # Add the user-specified flags.
  arguments.extend(ctx.attr.mocopts)

  # If we're compiling for a .h file, we #include it in the resulting
  # moc_$name.cpp.
  if src.path[src.path.rindex("."):] == ".h":
    arguments.append("-f" + src.path)

  # moc $src -o $out
  arguments.extend([src.path, "-o", out.path])

  # Inputs: the moc binary and the primary source file.
  inputs = [moc, src]
  # Make sure all files listed as srcs are in the execution environment.
  inputs.extend([
      extra_src_file
      for extra_src in ctx.attr.srcs
      for extra_src_file in extra_src.files.to_list()
  ])
  # Also add all transitive headers from deps to the environment.
  inputs.extend([
      dep_hdr
      for dep in ctx.attr.deps if hasattr(dep, "cc")
      for dep_hdr in dep.cc.transitive_headers.to_list()
  ])

  # Execute moc.
  ctx.actions.run(
      outputs = [out],
      inputs = inputs,
      executable = moc.path,
      arguments = arguments,
      mnemonic = "CompileMoc",
      progress_message = "Generating Qt MOC source for " + src.basename,
  )
  return DefaultInfo(files = depset([out]))

_qt_moc = rule(
    attrs = {
        "src": attr.label(allow_files = [
            ".cpp",
            ".h",
        ]),
        "srcs": attr.label_list(allow_files = [".h"]),
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

def qt_moc(name, src, srcs=[], deps=[], mocopts=[]):
  """Compiles a QT UI file and makes a library for it.

  Args:
    name: A name for the rule.
    src: The .h or .cpp file to generate moc output for.
    srcs: Additional header files that may be #included.
    deps: cc_library dependencies used for headers that may be #included. This
      includes the Qt libraries from @qt the source file uses.
    mocopts: Additional options for the moc tool.
  """
  if src.endswith(".h"):
    dirname, filename = src[:-2].rsplit("/", 1)
    out = "%s/moc_%s.cpp" % (dirname, filename)
  elif src.endswith(".cpp"):
    out = "%s.moc" % src[:-4]
    # The actual target will be a cc_library, because this is going to be
    # included as a dep in the actual binary, so the .cpp file there can
    # #include the .moc file generated here.
    native.cc_library(
        name = name,
        hdrs = [":" + out],
    )
    name = name + "_source"
  else:
    fail("src suffix not supported (allowed: .h, .cpp): " + src)

  _qt_moc(
      name = name,
      src = src,
      srcs = srcs,
      out = out,
      mocopts = mocopts,
      deps = deps,
  )

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
