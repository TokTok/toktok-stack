load("@rules_cc//cc:defs.bzl", "cc_library")
load("@toktok//third_party/yasm:build_defs.bzl", "asm_library")

asm_library(
    name = "assemblies",
    srcs = glob([
        "vp*/**/x86/*.asm",
    ]) + [
        "vpx_ports/float_control_word.asm",
    ] + select({
        "@toktok//tools/config:linux": [],
        "@toktok//tools/config:windows": ["vpx_ports/emms_mmx.asm"],
    }),
    hdrs = [
        "third_party/x86inc/x86inc.asm",
        "vpx_dsp/x86/bitdepth_conversion_sse2.asm",
        "vpx_ports/x86_abi_support.asm",
    ] + select({
        "@toktok//tools/config:linux": ["@toktok//third_party/libvpx:linux-x86_64/vpx_config.asm"],
        "@toktok//tools/config:windows": ["@toktok//third_party/libvpx:windows-x86_64/vpx_config.asm"],
    }),
    archive = False,
    asmopts = [
        "-I$(GENDIR)/external/libvpx",  # Generated headers.
        "-Iexternal/libvpx",
    ] + select({
        "@toktok//tools/config:linux-x86_64": ["-Ithird_party/libvpx/linux-x86_64"],
        "@toktok//tools/config:windows-x86_64": ["-Ithird_party/libvpx/windows-x86_64"],
    }),
)

CONFIGURE = """
export PATH="$$PATH:$$PWD/$$(dirname $(location @diffutils//:diff))"
export PATH="$$PATH:$$PWD/$$(dirname $(location @gnumake))"
export PATH="$$PATH:$$PWD/$$(dirname $(location @perl))"
export PATH="$$PATH:$$PWD/$$(dirname $(location @yasm))"
if [[ "$(CC)" == /* ]]; then
  export CC="$(CC)"
  export CXX="$(CC)"
else
  export CC="$$PWD/$(CC)"
  export CXX="$$PWD/$(CC)"
fi

cd `dirname $(location configure)`
mkdir -p gcc-wrapper
echo '"$$CC" "$$@"' > gcc-wrapper/gcc
chmod +x gcc-wrapper/gcc
export PATH="$$PATH:$$PWD/gcc-wrapper"

./configure \
    --disable-avx512 \
    --disable-webm-io \
    --enable-pic \
    --enable-shared \
    --enable-postproc \
    --enable-vp9-temporal-denoising \
    --enable-vp9-highbitdepth \
    --enable-error-concealment \
    --enable-internal-stats || (cat config.log && false)
make vpx_version.h
DIR=`pwd`
cd -
for i in $(OUTS); do
  cp $$DIR/`basename $$i` $$i
done
"""

genrule(
    name = "config-linux-arm64",
    srcs = glob(["**/*"]),
    outs = [
        "linux-arm64/libs-arm64-linux-gcc.mk",
        "linux-arm64/vpx_config.h",
        "linux-arm64/vpx_version.h",
    ],
    cmd = CONFIGURE,
    toolchains = ["@rules_cc//cc:current_cc_toolchain"],
    tools = [
        "@diffutils//:diff",
        "@gnumake",
        "@perl",
        "@yasm",
    ],
)

genrule(
    name = "config-linux-x86_64",
    srcs = glob(["**/*"]),
    outs = [
        "linux-x86_64/libs-x86_64-linux-gcc.mk",
        "linux-x86_64/vpx_config.asm",
        "linux-x86_64/vpx_config.h",
        "linux-x86_64/vpx_version.h",
    ],
    cmd = CONFIGURE,
    toolchains = ["@rules_cc//cc:current_cc_toolchain"],
    tools = [
        "@diffutils//:diff",
        "@gnumake",
        "@perl",
        "@yasm",
    ],
)

genrule(
    name = "config-windows-x86_64",
    srcs = glob(["**/*"]),
    outs = [
        "windows-x86_64/libs-x86_64-windows-gcc.mk",
        "windows-x86_64/vpx_config.asm",
        "windows-x86_64/vpx_config.h",
        "windows-x86_64/vpx_version.h",
    ],
    cmd = CONFIGURE,
    toolchains = ["@rules_cc//cc:current_cc_toolchain"],
    tools = [
        "@diffutils//:diff",
        "@gnumake",
        "@perl",
        "@yasm",
    ],
)

alias(
    name = "config",
    actual = select({
        "@toktok//tools/config:linux-arm64": ":config-linux-arm64",
        "@toktok//tools/config:linux-x86_64": ":config-linux-x86_64",
        "@toktok//tools/config:windows-x86_64": ":config-windows-x86_64",
    }),
)

RTCDS = [
    ("vp8", "vp8/common/rtcd_defs.pl"),
    ("vp9", "vp9/common/vp9_rtcd_defs.pl"),
    ("vpx_dsp", "vpx_dsp/vpx_dsp_rtcd_defs.pl"),
    ("vpx_scale", "vpx_scale/vpx_scale_rtcd.pl"),
]

[genrule(
    name = "%s_%s_rtcd" % (cpu, mod),
    srcs = [
        "build/make/rtcd.pl",
        "@toktok//third_party/libvpx:libs.mk",
        defs,
    ],
    outs = ["%s/%s_rtcd.h" % (cpu, mod)],
    cmd = " ".join([
        "$(location @perl)",
        "$(location build/make/rtcd.pl)",
        "--arch=%s" % cpu,
        "--sym=%s_rtcd" % mod,
        "--disable-avx512",
        "--config=$(location @toktok//third_party/libvpx:libs.mk)",
        "$(location %s)" % defs,
        "> $@",
    ]),
    tools = ["@perl"],
) for mod, defs in RTCDS for cpu in [
    "arm64",
    "x86_64",
]]

[genrule(
    name = "%s_rtcd" % mod,
    srcs = select({
        "@toktok//tools/config:arm64": ["arm64_%s_rtcd" % mod],
        "@toktok//tools/config:x86_64": ["x86_64_%s_rtcd" % mod],
    }),
    outs = ["%s_rtcd.h" % mod],
    cmd = "cp $< $@",
) for mod, _ in RTCDS]

HDRS = glob(["**/*.h"]) + ["%s_rtcd.h" % mod for mod, _ in RTCDS]

cc_library(
    name = "headers_private",
    hdrs = HDRS,
    deps = ["@toktok//third_party/libvpx:vpx_config"],
)

filegroup(
    name = "headers",
    srcs = HDRS,
    visibility = ["//visibility:public"],
)

cc_library(
    name = "libvpx",
    srcs = glob(
        ["vp*/**/*.c"],
        exclude = [
            "**/arm/**",
            "**/loongarch/**",
            "**/mips/**",
            "**/ppc/**",
            "**/x86/**",
            "vp8/encoder/mr_dissim.c",
            "vpx_ports/aarch32_cpudetect.c",
            "vpx_ports/aarch64_cpudetect.c",
            "vpx_ports/loongarch_cpudetect.c",
            "vpx_ports/mips_cpudetect.c",
            "vpx_ports/ppc_cpudetect.c",
            "vpx_ports/emms_mmx.c",
        ],
    ) + select({
        "@toktok//tools/config:arm64": glob(
            ["vp*/**/arm/**/*.c"],
            exclude = ["vpx_dsp/arm/vpx_convolve8_neon_asm.c"],
        ) + ["vpx_ports/aarch64_cpudetect.c"],
        "@toktok//tools/config:x86_64": glob(
            ["vp*/**/x86/**/*.c"],
            exclude = ["**/*_avx512.c"],
        ) + [
            "vpx_ports/emms_mmx.c",
            ":assemblies",
        ],
    }),
    hdrs = [
        "vpx/vp8cx.h",
        "vpx/vp8dx.h",
        "vpx/vpx_decoder.h",
        "vpx/vpx_encoder.h",
        "vpx/vpx_image.h",
    ],
    copts = select({
        "@toktok//tools/config:windows": [],
        "//conditions:default": ["-fvisibility=protected"],
    }),
    includes = ["."],
    linkopts = select({
        "@toktok//tools/config:windows": [],
        "//conditions:default": ["-lm"],
    }),
    visibility = ["//visibility:public"],
    deps = [
        ":headers_private",
        "@pthread",
        "@toktok//third_party/libvpx:vpx_config",
        "@toktok//third_party/libvpx:vpx_version",
    ],
)
