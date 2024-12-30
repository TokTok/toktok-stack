load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "openssl",
    srcs = ["@openssl.out//:lib"],
    hdrs = glob(["include/openssl/*.h"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
