def qt_ui_library(name, ui, deps=None):
  """Compiles a QT UI file and makes a library for it.

  Args:
    name: A name for the rule.
    src: The ui file to compile.
    deps: cc_library dependencies for the library.
  """
  native.genrule(
      name = "%s_uic" % name,
      srcs = [ui],
      outs = ["ui_%s.h" % ui.rsplit("/", 1)[1].split(".")[0]],
      cmd = "uic $(locations %s) -o $@" % ui,
  )

  native.cc_library(
      name = name,
      hdrs = [":%s_uic" % name],
      deps = deps,
  )

def qt_moc(name, hdr, mocopts=[], deps=[]):
  deps = [dep for dep in deps if dep != hdr]
  native.genrule(
      name = name,
      srcs = [hdr] + deps,
      outs = ["moc_%s.cpp" % name],
      cmd = "moc {mocopts} $(location {hdr}) -o $@ -f'{hdr}'".format(
        mocopts=" ".join(mocopts),
  	hdr=hdr,
      ),
  )

def qt_rcc(name, srcs, data):
  native.genrule(
      name = "%s_rcc" % name,
      srcs = srcs + data,
      outs = ["rcc_%s.cpp" % name],
      cmd = "rcc {} -o $@".format(" ".join(["$(location %s)" % src for src in srcs])),
  )

  native.cc_library(
      name = name,
      srcs = [":%s_rcc" % name],
      deps = ["@qt//:qt_core"],
      alwayslink = True,
  )
