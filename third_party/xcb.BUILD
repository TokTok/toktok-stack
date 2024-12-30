# bazel
load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "xcb",
    srcs = ["@xcb.out//:lib"],
    hdrs = glob(["include/xcb/*.h"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
