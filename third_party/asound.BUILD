load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "asound",
    srcs = ["@alsa-lib//:lib"],
    hdrs = glob(["include/alsa/*.h"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
