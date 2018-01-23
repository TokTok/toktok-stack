"""Overrides cc_library to generate an empty binary in addition to the library.

This to ensure completeness of linkopts and dependencies for libraries. The
empty binary will fail to link if there are any undefined references.
"""

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
