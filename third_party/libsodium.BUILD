load("@rules_cc//cc:defs.bzl", "cc_library")

_REGEN_SRCS = glob([
    "m4/*",
    "**/*.am",
]) + [
    "configure.ac",
    "libsodium.pc.in",
    "libsodium-uninstalled.pc.in",
    "src/libsodium/include/sodium/version.h.in",
    "src/libsodium/sodium/version.c",
]

_REGEN_TOOLS = [
    "@autoconf",
    "@autoconf//:autoreconf",
    "@automake",
    "@automake//:aclocal",
    "@diffutils//:cmp",
    "@gnumake",
    "@libtool//:libtool.m4",
    "@libtool//:libtoolize",
    "@m4",
]

# Get autotools on PATH and run autoreconf. Each genrule then calls ./configure
# with its own flags and extracts the DEFS into a header.
_REGEN_SETUP = """
    export PATH="$$PATH:$$PWD/$$(dirname $(execpath @autoconf//:autoconf))"
    export PATH="$$PATH:$$PWD/$$(dirname $(execpath @automake//:aclocal))"
    export PATH="$$PATH:$$PWD/$$(dirname $(execpath @diffutils//:cmp))"
    export PATH="$$PATH:$$PWD/$$(dirname $(execpath @gnumake))"
    export PATH="$$PATH:$$PWD/$$(dirname $(execpath @libtool//:libtoolize))"
    export PATH="$$PATH:$$PWD/$$(dirname $(execpath @m4))"

    SRCDIR="$$(dirname $(execpath configure.ac))"
    autoreconf -fi -I "$$PWD/$$(dirname $(execpath @libtool//:libtool.m4))" "$$SRCDIR"
"""

genrule(
    name = "regen_config",
    srcs = _REGEN_SRCS,
    outs = [
        "src/libsodium/include/sodium/version.h",
        "src/sodium_config.h",
    ],
    cmd = _REGEN_SETUP + """
        "$$SRCDIR/configure" CC="$(CC)" || (cat config.log && false)

        cp "src/libsodium/include/sodium/version.h" "$(execpath src/libsodium/include/sodium/version.h)"
        grep '^DEFS = ' Makefile $(execpath src/libsodium/include/sodium/version.h) \\
          | grep -E -o -- '-D([^ ]|\\\\ )+' \\
          | sed -e 's/^-D/#define /;s/=/ /;s/\\\\//g' \\
          > "$(execpath src/sodium_config.h)"
    """,
    toolchains = ["@rules_cc//cc:current_cc_toolchain"],
    tools = _REGEN_TOOLS,
)

# Mirrors regen_config but passes --disable-asm AND strips the
# HAVE_*INTRIN_H detection macros from the output. libsodium's SIMD dispatchers
# gate on those (e.g. poly1305 picks the SSE2 impl when HAVE_EMMINTRIN_H is
# defined), so dropping them forces the pure-C fallbacks. Used under
# --config=msan, where the SIMD impls confuse MSan's shadow tracking.
genrule(
    name = "regen_config_no_simd",
    srcs = _REGEN_SRCS,
    outs = ["src/sodium_config_no_simd.h"],
    cmd = _REGEN_SETUP + """
        "$$SRCDIR/configure" CC="$(CC)" --disable-asm || (cat config.log && false)

        grep '^DEFS = ' Makefile \\
          | grep -E -o -- '-D([^ ]|\\\\ )+' \\
          | sed -e 's/^-D/#define /;s/=/ /;s/\\\\//g' \\
          | grep -v -E '^#define HAVE_[A-Z0-9]*INTRIN_H ' \\
          > "$(execpath src/sodium_config_no_simd.h)"
    """,
    toolchains = ["@rules_cc//cc:current_cc_toolchain"],
    tools = _REGEN_TOOLS,
)

HEADERS = glob([
    "src/libsodium/include/**/*.h",
])

genrule(
    name = "headers",
    srcs = HEADERS + ["@toktok//third_party/libsodium:version.h"],
    outs = [hdr[len("src/libsodium/"):] for hdr in HEADERS] + ["include/sodium/version.h"],
    cmd = "\n".join(["cp $(execpath @toktok//third_party/libsodium:version.h) $(execpath include/sodium/version.h)"] + [
        "cp $(execpath %s) $(execpath %s)" % (
            hdr,
            hdr[len("src/libsodium/"):],
        )
        for hdr in HEADERS
    ]),
    visibility = ["//visibility:public"],
)

SRCS_X86_64 = [
    "src/libsodium/**/*-avx2.c",
    "src/libsodium/**/*-avx512.c",
    "src/libsodium/**/*-avx512f.c",
    "src/libsodium/**/sse/*.c",
    "src/libsodium/**/*-sse41.c",
    "src/libsodium/**/*-ssse3.c",
]

alias(
    name = "config",
    actual = select({
        "@toktok//tools/config:linux-arm64": "@toktok//third_party/libsodium:config/linux-arm64.h",
        "@toktok//tools/config:linux-x86_64": "@toktok//third_party/libsodium:config/linux-x86_64.h",
        "@toktok//tools/config:linux-x86_64-msan": "@toktok//third_party/libsodium:config/linux-x86_64-no-simd.h",
        "@toktok//tools/config:macos-arm64": "@toktok//third_party/libsodium:config/macos-arm64.h",
        "@toktok//tools/config:windows-x86_64": "@toktok//third_party/libsodium:config/windows-x86_64.h",
    }),
)

cc_library(
    name = "libsodium",
    srcs = [":config"] + glob(
        [
            "src/libsodium/**/*.h",
            "src/libsodium/**/*.c",
        ],
        exclude = SRCS_X86_64,
    ) + select({
        "@toktok//tools/config:arm64": [],
        "@toktok//tools/config:linux-x86_64": glob(SRCS_X86_64 + ["src/libsodium/**/*.S"]),
        "@toktok//tools/config:windows-x86_64": glob(SRCS_X86_64),
    }),
    hdrs = [":headers"],
    copts = [
        "-DSODIUM_DLL_EXPORT",
        "-include $(execpath :config)",
        "-Wno-strict-aliasing",
        "-Wno-unknown-pragmas",
        "-Wno-unused",
    ] + select({
        "@toktok//tools/config:arm64": [],
        "@toktok//tools/config:x86_64": [
            "-maes",
            "-mpclmul",
            "-mrdrnd",
            "-mssse3",
        ],
    }),
    defines = ["SODIUM_STATIC"],
    includes = [
        "include/sodium",
        "src/libsodium/include",
        "src/libsodium/include/sodium",
    ],
    strip_include_prefix = "include",
    textual_hdrs = glob(["src/libsodium/**/*.S"]),
    visibility = ["//visibility:public"],
)
