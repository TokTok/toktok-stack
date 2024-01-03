load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "glvnd",
    srcs = ["@glvnd.out//:lib"],
    hdrs = glob(["include/**/*.h"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
