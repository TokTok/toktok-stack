load("@rules_cc//cc:defs.bzl", "cc_library")

filegroup(
    name = "include",
    srcs = ["include/pcre.h"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "pcre",
    srcs = ["@pcre.out//:lib"],
    hdrs = ["include/pcre.h"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
