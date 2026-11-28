load("@rules_cc//cc:defs.bzl", "cc_library")

genrule(
    name = "pcre_h",
    srcs = ["pcre.h.generic"],
    outs = ["pcre.h"],
    cmd = "cp $< $@",
)

genrule(
    name = "config_h",
    srcs = ["config.h.generic"],
    outs = ["config.h"],
    cmd = "cp $< $@",
)

genrule(
    name = "pcre_chartables_c",
    srcs = ["pcre_chartables.c.dist"],
    outs = ["pcre_chartables.c"],
    cmd = "cp $< $@",
)

filegroup(
    name = "include",
    srcs = ["pcre.h"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "pcre",
    srcs = [
        "config.h",
        "pcre_byte_order.c",
        "pcre_chartables.c",
        "pcre_compile.c",
        "pcre_config.c",
        "pcre_dfa_exec.c",
        "pcre_exec.c",
        "pcre_fullinfo.c",
        "pcre_get.c",
        "pcre_globals.c",
        "pcre_internal.h",
        "pcre_jit_compile.c",
        "pcre_maketables.c",
        "pcre_newline.c",
        "pcre_ord2utf8.c",
        "pcre_refcount.c",
        "pcre_string_utils.c",
        "pcre_study.c",
        "pcre_tables.c",
        "pcre_ucd.c",
        "pcre_valid_utf8.c",
        "pcre_version.c",
        "pcre_xclass.c",
        "ucp.h",
    ],
    hdrs = ["pcre.h"],
    copts = [
        "-DHAVE_CONFIG_H",
        "-DHAVE_INTTYPES_H",
        "-DHAVE_LIMITS_H",
        "-DHAVE_MEMMOVE",
        "-DHAVE_STDINT_H",
        "-DHAVE_STDLIB_H",
        "-DHAVE_STRERROR",
        "-DHAVE_STRING_H",
        "-DSUPPORT_PCRE8",
        "-DSUPPORT_UCP",
        "-DSUPPORT_UTF",
    ],
    defines = ["PCRE_STATIC"],
    includes = ["."],
    visibility = ["//visibility:public"],
)
