load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "gettext_TODO",
    srcs = ["gettext-runtime/src/gettext.c"],
    hdrs = [
        "include/libintl.h",
    ],
    includes = ["include"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "gettext",
    visibility = ["//visibility:public"],
)
