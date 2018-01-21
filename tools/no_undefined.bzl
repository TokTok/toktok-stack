def cc_library(name, hdrs=[], srcs=[], deps=[], visibility=None, **kwargs):
  native.cc_library(
      name = name,
      srcs = srcs,
      hdrs = hdrs,
      deps = deps,
      visibility = visibility,
      **kwargs
  )

  native.cc_binary(
      name = "%s_bin" % name,
      srcs = hdrs + srcs,
      deps = deps + ["//tools:empty_main"],
      **kwargs
  )
