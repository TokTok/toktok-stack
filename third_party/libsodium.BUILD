load("@rules_cc//cc:defs.bzl", "cc_library")

genrule(
    name = "regen_config",
    srcs = glob([
        "m4/*",
        "**/*.am",
    ]) + [
        "configure.ac",
        "libsodium.pc.in",
        "libsodium-uninstalled.pc.in",
        "src/libsodium/include/sodium/version.h.in",
        "src/libsodium/sodium/version.c",
    ],
    outs = [
        "src/libsodium/include/sodium/version.h",
        "src/sodium_config.h",
    ],
    cmd = """
        BASE=`pwd`
        export PATH="$$PATH:$$BASE/$$(dirname $(location @autoconf//:autoconf))"
        export PATH="$$PATH:$$BASE/$$(dirname $(location @automake//:aclocal))"
        export PATH="$$PATH:$$BASE/$$(dirname $(location @diffutils//:cmp))"
        export PATH="$$PATH:$$BASE/$$(dirname $(location @libtool//:libtoolize))"
        export PATH="$$PATH:$$BASE/$$(dirname $(location @m4))"
        cd "$$(dirname $(location configure.ac))"
        autoreconf -fi
        ./configure CC="$(CC)" MAKE="$$BASE/$(location @gnumake)" || (cat config.log && false)
        cd -
        find . -name sodium_config.h
        cp "$$(dirname $(location configure.ac))/src/libsodium/include/sodium/version.h" "$(location src/libsodium/include/sodium/version.h)"
        grep '^DEFS = ' $$(dirname $(location configure.ac))/Makefile $(location src/libsodium/include/sodium/version.h) \\
          | grep -E -o -- '-D([^ ]|\\\\ )+' \\
          | sed -e 's/^-D/#define /;s/=/ /;s/\\\\//g' \\
          > "$(location src/sodium_config.h)"
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

HEADERS = glob([
    "src/libsodium/include/**/*.h",
])

genrule(
    name = "headers",
    srcs = HEADERS + ["@toktok//third_party/libsodium:version.h"],
    outs = [hdr[len("src/libsodium/"):] for hdr in HEADERS] + ["include/sodium/version.h"],
    cmd = "\n".join(["cp $(location @toktok//third_party/libsodium:version.h) $(location include/sodium/version.h)"] + [
        "cp $(location %s) $(location %s)" % (
            hdr,
            hdr[len("src/libsodium/"):],
        )
        for hdr in HEADERS
    ]),
    visibility = ["//visibility:public"],
)

SRCS_X86_64 = [
    "src/libsodium/**/*-avx2.c",
    "src/libsodium/**/*-avx512f.c",
    "src/libsodium/**/sse/*.c",
    "src/libsodium/**/*-sse41.c",
    "src/libsodium/**/*-ssse3.c",
]

alias(
    name = "config",
    actual = select({
        "@toktok//tools/config:arm64": "@toktok//third_party/libsodium:config/arm64.h",
        "@toktok//tools/config:linux-x86_64": "@toktok//third_party/libsodium:config/linux-x86_64.h",
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
        "-I$(GENDIR)/external/libsodium/include/sodium",
        "-include $(location :config)",
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
    strip_include_prefix = "include",
    textual_hdrs = glob(["src/libsodium/**/*.S"]),
    visibility = ["//visibility:public"],
)
