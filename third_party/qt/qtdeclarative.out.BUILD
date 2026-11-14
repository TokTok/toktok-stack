load("@rules_cc//cc:defs.bzl", "cc_library")

exports_files([
    "libexec/qmltyperegistrar",
])

filegroup(
    name = "qml_modules",
    srcs = glob(["lib/qt-6/qml/**"]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "metatypes",
    srcs = glob(["metatypes/*.json"]),
    visibility = ["//visibility:public"],
)

# The macros that name a C++ type for QML (QML_ELEMENT and so on).
cc_library(
    name = "qmlintegration",
    hdrs = glob(["include/QtQmlIntegration/**"]),
    includes = [
        "include",
        "include/QtQmlIntegration",
    ],
)

[cc_library(
    name = mod.lower(),
    srcs = glob(["lib/libQt6%s.so*" % mod]),
    hdrs = glob(["include/Qt%s/**" % mod]),
    defines = ["QT_%s_LIB" % mod.upper()],
    includes = [
        "include",
        "include/Qt" + mod,
    ],
    visibility = ["//visibility:public"],
    deps = deps,
) for mod, deps in {
    "Qml": [":qmlintegration"],
    "QmlMeta": [":qml"],
    "QmlModels": [":qml"],
    "QmlWorkerScript": [":qml"],
    "Quick": [
        ":qml",
        ":qmlmeta",
        ":qmlmodels",
        ":qmlworkerscript",
    ],
    "QuickControls2": [
        ":quick",
        ":quicktemplates2",
    ],
    "QuickTemplates2": [":quick"],
}.items()]
