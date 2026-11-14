load("@rules_cc//cc:defs.bzl", "cc_library")

filegroup(
    name = "metatypes",
    srcs = glob(["metatypes/*.json"]),
    visibility = ["//visibility:public"],
)

[cc_library(
    name = mod.lower(),
    srcs = glob(["lib/libQt6%s.so*" % mod]),
    visibility = ["//visibility:public"],
) for mod in [
    "Concurrent",
    "Core",
    "DBus",
    "Gui",
    "OpenGL",
    "PrintSupport",
    "Network",
    "Test",
    "Widgets",
    "Xml",
]]
