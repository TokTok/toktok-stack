# bazel
load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "xss",
    srcs = glob(["lib/libXss.so*"]),
    hdrs = ["include/X11/extensions/scrnsaver.h"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
