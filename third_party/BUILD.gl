load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "gl",
    srcs = ["@gl.out//:lib"],
    hdrs = glob(["include/GL/**/*.h"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
