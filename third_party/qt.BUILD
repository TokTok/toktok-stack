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
    actual = "@qt6.qtremoteobjects//:libexec/%s" % name,
    visibility = ["//visibility:public"],
) for name in [
    "repc",
]]

[alias(
    name = name,
    actual = "@qt6.qtdeclarative.out//:libexec/%s" % name,
    visibility = ["//visibility:public"],
) for name in [
    "qmltyperegistrar",
]]

# The QML modules of Qt Quick, for QML_IMPORT_PATH.
alias(
    name = "qt_qml_modules",
    actual = "@qt6.qtdeclarative.out//:qml_modules",
    visibility = ["//visibility:public"],
)

# What qmltyperegistrar knows Qt's own types from.
filegroup(
    name = "qt_metatypes",
    srcs = [
        "@qt6.qtbase.out//:metatypes",
        "@qt6.qtdeclarative.out//:metatypes",
    ],
    visibility = ["//visibility:public"],
)

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
    "PrintSupport",
    "Network",
    "Test",
    "Widgets",
    "Xml",
]]

[alias(
    name = "qt_" + mod.lower(),
    actual = "@qt6.qtremoteobjects//:" + mod.lower(),
    visibility = ["//visibility:public"],
) for mod in [
    "RemoteObjects",
]]

[alias(
    name = "qt_" + mod.lower(),
    actual = "@qt6.qtdeclarative.out//:" + mod.lower(),
    visibility = ["//visibility:public"],
) for mod in [
    "Qml",
    "Quick",
    "QuickControls2",
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
        ":qt_printsupport",
        ":qt_remoteobjects",
        ":qt_svg",
        ":qt_test",
        ":qt_widgets",
        ":qt_xml",
    ],
    visibility = ["@toktok//third_party:__pkg__"],
)
