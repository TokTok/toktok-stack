load("@rules_cc//cc:defs.bzl", "cc_library")

licenses(["notice"])

REPO_ROOT = package_relative_label(":BUILD.bazel").workspace_root

INCLUDES = [
    "codec/api/wels",
    "codec/common/inc",
    "codec/encoder/core/inc",
    "codec/encoder/plus/inc",
    "codec/processing/interface",
    "codec/processing/src/adaptivequantization",
    "codec/processing/src/common",
    "codec/processing/src/downsample",
    "codec/processing/src/scrolldetection",
    "codec/processing/src/vaacalc",
]

# The encoder only, without assembly.
cc_library(
    name = "openh264",
    srcs = glob(
        [
            "codec/common/inc/*.h",
            "codec/common/src/*.cpp",
            "codec/encoder/core/inc/*.h",
            "codec/encoder/core/src/*.cpp",
            "codec/encoder/plus/inc/*.h",
            "codec/encoder/plus/src/*.cpp",
            "codec/processing/interface/*.h",
            "codec/processing/src/**/*.cpp",
            "codec/processing/src/**/*.h",
        ],
        exclude = ["codec/encoder/plus/src/DllEntry.cpp"],
    ),
    hdrs = glob(["codec/api/wels/*.h"]),
    copts = [
        "-Wno-non-virtual-dtor",
        "-Wno-strict-aliasing",
        "-w",
        # It shifts 32-bit values by 32, and ffmpeg gives it a profile outside
        # its enum.
        "-fno-sanitize=undefined",
    ] + ["-I%s/%s" % (REPO_ROOT, d) for d in INCLUDES],
    include_prefix = "wels",
    linkopts = ["-lpthread"],
    strip_include_prefix = "codec/api/wels",
    visibility = ["//visibility:public"],
)
