load("@rules_cc//cc:defs.bzl", "cc_library")

[cc_library(
    name = mod.lower(),
    srcs = glob(["lib/libQt6%s.so*" % mod]),
    visibility = ["//visibility:public"],
) for mod in [
    "Svg",
]]
