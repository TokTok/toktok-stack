load("@rules_cc//cc:defs.bzl", "cc_library")

exports_files([
    "libexec/moc",
    "libexec/rcc",
    "libexec/uic",
])

filegroup(
    name = "plugins",
    srcs = glob([
        "lib/qt-6/plugins/platforms/*offscreen*",
        "lib/qt-6/plugins/platforms/*xcb*",
        "lib/qt-6/plugins/tls/*opensslbackend*",
        "lib/qt-6/plugins/imageformats/*",
    ]),
    visibility = ["//visibility:public"],
)

[cc_library(
    name = mod.lower(),
    hdrs = glob(["include/Qt%s/**" % mod]),
    defines = ["QT_%s_LIB" % mod.upper()],
    includes = [
        "include",
        "include/Qt" + mod,
    ],
    visibility = ["//visibility:public"],
    deps = ["@qt6.qtbase.out//:" + mod.lower()],
) for mod in [
    "Concurrent",
    "Core",
    "DBus",
    "Gui",
    "OpenGL",
    "Network",
    "Test",
    "Widgets",
    "Xml",
]]
