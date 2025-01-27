load("@rules_cc//cc:defs.bzl", "cc_library")

genrule(
    name = "config",
    outs = ["dummy/config.h"],
    cmd = "touch $@",
)

cc_library(
    name = "libxz",
    srcs = glob(
        [
            "src/common/*.c",
            "src/common/*.h",
            "src/liblzma/**/*.c",
            "src/liblzma/**/*.h",
        ],
        exclude = [
            "**/*_tablegen.c",
            "src/liblzma/check/crc*_small.c",
        ],
    ) + ["dummy/config.h"],
    hdrs = glob(["src/liblzma/api/**/*.h"]),
    copts = [
        "-DHAVE_CONFIG_H",
        "-DHAVE_DECODER_LZMA1",
        "-DHAVE_DECODER_LZMA2",
        "-DHAVE_DECODER_X86",
        "-DHAVE_ENCODER_LZMA1",
        "-DHAVE_ENCODER_LZMA2",
        "-DHAVE_ENCODER_X86",
        "-DHAVE_INTTYPES_H",
        "-DHAVE_LIMITS_H",
        "-DHAVE_MEMORY_H",
        "-DHAVE_STDBOOL_H",
        "-DHAVE_STDINT_H",
        "-DHAVE_STRING_H",
        "-DHAVE_VISIBILITY",
        "-I$(GENDIR)/external/libxz/dummy",
        "-Iexternal/libxz/src/common",
        "-Iexternal/libxz/src/liblzma/check",
        "-Iexternal/libxz/src/liblzma/common",
        "-Iexternal/libxz/src/liblzma/delta",
        "-Iexternal/libxz/src/liblzma/lz",
        "-Iexternal/libxz/src/liblzma/lzma",
        "-Iexternal/libxz/src/liblzma/rangecoder",
        "-Iexternal/libxz/src/liblzma/simple",
    ] + select({
        "@toktok//tools/config:windows": ["-DMYTHREAD_VISTA"],
        "//conditions:default": [
            "-D_POSIX_C_SOURCE=199506L",
            "-DMYTHREAD_POSIX",
            "-Wno-overlength-strings",
            "-Wno-unused-function",
        ],
    }),
    linkopts = select({
        "@toktok//tools/config:windows": [],
        "//conditions:default": ["-lpthread"],
    }),
    strip_include_prefix = "src/liblzma/api",
    visibility = ["//visibility:public"],
)
