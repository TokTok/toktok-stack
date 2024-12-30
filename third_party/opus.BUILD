load("@rules_cc//cc:defs.bzl", "cc_library")

genrule(
    name = "autoreconf",
    srcs = glob([
        "*.mk",
        "**/*.am",
        "**/*.in",
    ]) + [
        "AUTHORS",
        "ChangeLog",
        "COPYING",
        "NEWS",
        "README",
        "configure.ac",
        "m4/as-gcc-inline-assembly.m4",
        "m4/opus-intrinsics.m4",
        "src/opus_encoder.c",
        "@libtool//:libtool.m4",
    ],
    outs = ["config.h"],
    cmd = """
        export PATH="$$PATH:$$PWD/$$(dirname $(location @autoconf//:autoconf))"
        export PATH="$$PATH:$$PWD/$$(dirname $(location @automake//:aclocal))"
        export PATH="$$PATH:$$PWD/$$(dirname $(location @diffutils//:cmp))"
        export PATH="$$PATH:$$PWD/$$(dirname $(location @gnumake))"
        export PATH="$$PATH:$$PWD/$$(dirname $(location @libtool//:libtoolize))"
        export PATH="$$PATH:$$PWD/$$(dirname $(location @m4))"

        SRCDIR="$$(dirname $(location configure.ac))"
        autoreconf -fi -I "$$PWD/$$(dirname $(location @libtool//:libtool.m4))" "$$SRCDIR"
        "$$SRCDIR/configure" CC="$(CC)"
        cp config.h "$@"
    """,
    toolchains = ["@rules_cc//cc:current_cc_toolchain"],
    tools = [
        "@autoconf",
        "@autoconf//:autoreconf",
        "@automake",
        "@automake//:aclocal",
        "@diffutils//:cmp",
        "@gnumake",
        "@libtool//:libtoolize",
        "@m4",
    ],
)

HDRS = glob(["include/*.h"])

filegroup(
    name = "headers",
    srcs = HDRS,
    visibility = ["//visibility:public"],
)

cc_library(
    name = "opus",
    srcs = glob(
        [
            "celt/*.c",
            "silk/*.c",
            "silk/float/*.c",
            "**/*.h",
        ],
        exclude = [
            "celt/opus_custom_demo.c",
        ],
    ) + [
        "src/analysis.c",
        "src/extensions.c",
        "src/mlp.c",
        "src/mlp_data.c",
        "src/opus.c",
        "src/opus_decoder.c",
        "src/opus_encoder.c",
        "src/opus_multistream.c",
        "src/opus_multistream_decoder.c",
        "src/opus_multistream_encoder.c",
        "src/repacketizer.c",
    ] + select({
        "@toktok//tools/config:arm64": [
            "celt/arm/armcpu.c",
        ],
        "@toktok//tools/config:x86_64": [
            "celt/x86/pitch_sse.c",
            "celt/x86/pitch_sse2.c",
            "celt/x86/pitch_sse4_1.c",
            "celt/x86/vq_sse2.c",
            "celt/x86/x86_celt_map.c",
            "celt/x86/x86cpu.c",
            "silk/x86/NSQ_del_dec_sse4_1.c",
            "silk/x86/NSQ_sse4_1.c",
            "silk/x86/VAD_sse4_1.c",
            "silk/x86/VQ_WMat_EC_sse4_1.c",
            "silk/x86/x86_silk_map.c",
        ],
    }),
    hdrs = HDRS,
    copts = [
        "-DHAVE_CONFIG_H",
        "-I$(GENDIR)/third_party/opus",
    ],
    includes = [
        "celt",
        "include",
        "silk",
        "silk/float",
    ],
    linkopts = select({
        "@toktok//tools/config:freebsd": [],
        "@toktok//tools/config:linux": ["-lm"],
        "@toktok//tools/config:osx": [],
        "@toktok//tools/config:windows": [],
    }),
    visibility = ["//visibility:public"],
    deps = ["@toktok//third_party/opus:config"],
)
