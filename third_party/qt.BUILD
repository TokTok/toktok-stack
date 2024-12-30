[alias(
    name = name,
    actual = "@qt6.qtbase//:libexec/%s" % name,
    visibility = ["//visibility:public"],
) for name in [
    "moc",
    "rcc",
    "uic",
]]

[alias(
    name = name,
    actual = "bin/%s" % name,
    visibility = ["//visibility:public"],
) for name in [
    "lconvert",
]]

alias(
    name = "qt_base_plugins",
    actual = "@qt6.qtbase//:plugins",
    visibility = ["//visibility:public"],
)

alias(
    name = "qt_svg_plugins",
    actual = "@qt6.qtsvg//:plugins",
    visibility = ["//visibility:public"],
)

[alias(
    name = "qt_" + mod.lower(),
    actual = "@qt6.qtbase//:" + mod.lower(),
    visibility = ["//visibility:public"],
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

[alias(
    name = "qt_" + mod.lower(),
    actual = "@qt6.qtsvg//:" + mod.lower(),
    visibility = ["//visibility:public"],
) for mod in [
    "Svg",
]]

filegroup(
    name = "qt",
    srcs = [
        ":qt_concurrent",
        ":qt_core",
        ":qt_dbus",
        ":qt_gui",
        ":qt_network",
        ":qt_opengl",
        ":qt_svg",
        ":qt_test",
        ":qt_widgets",
        ":qt_xml",
    ],
    visibility = ["@toktok//third_party:__pkg__"],
)
