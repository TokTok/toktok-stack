# bazel
load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "xproto",
    hdrs = glob(["include/X11/**/*.h"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
