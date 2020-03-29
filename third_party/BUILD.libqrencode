load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "libqrencode",
    srcs = glob(
        [
            "*.c",
            "*.h",
        ],
        exclude = ["qrenc.c"],
    ),
    hdrs = ["qrencode.h"],
    copts = [
        "-DSTATIC_IN_RELEASE=static",
        "-DMAJOR_VERSION=4",
        "-DMINOR_VERSION=0",
        "-DMICRO_VERSION=0",
        "-DVERSION='\"4.0.0\"'",
    ],
    includes = ["."],
    visibility = ["//visibility:public"],
)
