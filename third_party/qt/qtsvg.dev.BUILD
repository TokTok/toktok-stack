load("@rules_cc//cc:defs.bzl", "cc_library")

filegroup(
    name = "plugins",
    srcs = glob([
        "lib/qt-6/plugins/imageformats/*",
    ]),
    visibility = ["//visibility:public"],
)

[cc_library(
    name = mod.lower(),
    hdrs = glob(["include/Qt%s/**" % mod]),
    includes = [
        "include",
        "include/Qt" + mod,
    ],
    visibility = ["//visibility:public"],
    deps = ["@qt6.qtsvg.out//:" + mod.lower()],
) for mod in [
    "Svg",
]]
