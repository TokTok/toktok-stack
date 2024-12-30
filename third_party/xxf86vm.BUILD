# bazel
load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "xxf86vm",
    srcs = ["@xxf86vm.out//:lib"],
    hdrs = glob(["include/X11/**/*.h"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
