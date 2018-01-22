def qt_ui_library(name, ui, deps=None):
  """Compiles a QT UI file and makes a library for it.

  Args:
    name: A name for the rule.
    src: The ui file to compile.
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
  cpp_file = ctx.actions.declare_file("moc_%s.cpp" % ctx.attr.name)
  hdr = ctx.attr.hdr.files.to_list()[0]
  dep_hdrs = [
      dep_hdr
      for dep in ctx.attr.deps if hasattr(dep, "cc")
      for dep_hdr in dep.cc.transitive_headers.to_list()
  ]
  dep_includes = {
      "-I%s" % inc: None
      for dep in ctx.attr.deps if hasattr(dep, "cc")
      for inc in dep.cc.system_include_directories
  }.keys()

  moc = ctx.executable._moc

  ctx.actions.run(
      outputs = [cpp_file],
      inputs = [moc, hdr] + [f for t in ctx.attr.srcs for f in t.files] + dep_hdrs,
      executable = moc.path,
      arguments = ctx.attr.mocopts + dep_includes + [
          hdr.path,
          "-o",
          cpp_file.path,
          "-f" + hdr.path,
      ],
      mnemonic = "CompileMoc",
      progress_message = "Generating Qt MOC source",
  )

  return DefaultInfo(files=depset([cpp_file]))

qt_moc = rule(
    attrs = {
        "hdr": attr.label(allow_files = [".h"]),
        "srcs": attr.label_list(allow_files = [".h"]),
        "deps": attr.label_list(),
        "mocopts": attr.string_list(),
        "_moc": attr.label(
            default = Label("@qt//:bin/moc"),
            executable = True,
            cfg = "host",
            allow_single_file = True,
        ),
    },
    implementation = _qt_moc_impl,
)
