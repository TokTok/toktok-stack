load("@rules_cc//cc:defs.bzl", "cc_library")
load("@toktok//third_party/qt:build_defs.bzl", "qt_moc")

qt_moc(
    name = "kimageformats_moc",
    srcs = ["src/imageformats/xcf.cpp"] + glob(
        ["src/imageformats/*_p.h"],
        exclude = [
            "src/imageformats/avif_p.h",
            "src/imageformats/exr_p.h",
            "src/imageformats/fastmath_p.h",
            "src/imageformats/gimp_p.h",
            "src/imageformats/jxl_p.h",
            "src/imageformats/ora_p.h",
            "src/imageformats/rle_p.h",
            "src/imageformats/scanlineconverter_p.h",
            "src/imageformats/util_p.h",
        ],
    ),
    hdrs = glob(["src/imageformats/*.json"]),
    tags = ["qt"],
)

cc_library(
    name = "kimageformats",
    srcs = glob(
        [
            "src/imageformats/*.cpp",
            "src/imageformats/*.h",
        ],
        exclude = [
            "src/imageformats/avif.cpp",
            "src/imageformats/exr.cpp",
            "src/imageformats/kra.cpp",
            "src/imageformats/ora.cpp",
            "src/imageformats/jxl.cpp",
            "src/imageformats/jxr.cpp",
            "src/imageformats/heif.cpp",
            "src/imageformats/raw.cpp",
        ],
    ),
    copts = [
        "-I.",
        "-I$(GENDIR)/external/kimageformats/src/imageformats",
        "-DQT_STATICPLUGIN",
    ],
    textual_hdrs = [":kimageformats_moc"],
    visibility = ["//visibility:public"],
    deps = [
        "@qt//:qt_core",
        "@qt//:qt_gui",
        "@qt//:qt_printsupport",
        "@qt//:qt_widgets",
    ],
)
