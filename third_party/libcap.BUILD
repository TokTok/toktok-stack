load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

genrule(
    name = "cap_names_list",
    srcs = ["libcap/include/uapi/linux/capability.h"],
    outs = ["cap_names.list.h"],
    cmd = """
    $(location @perl) -e 'while ($$l=<>) { if ($$l =~ /^#define[ \\t](CAP[_A-Z]+)[ \\t]+([0-9]+)\\s+$$/) { $$tok=$$1; $$val=$$2; $$tok =~ tr/A-Z/a-z/; print "{\\"$$tok\\",$$val},\\n"; } }' $< | fgrep -v 0x > $@
    """,
    tools = ["@perl"],
)

cc_binary(
    name = "_makenames",
    srcs = [
        "cap_names.list.h",
        "libcap/_makenames.c",
        "libcap/include/sys/capability.h",
    ],
    copts = ["-Iexternal/libcap/libcap/include"],
)

genrule(
    name = "cap_names",
    outs = ["cap_names.h"],
    cmd = "$(location _makenames) > $@",
    tools = ["_makenames"],
)

cc_library(
    name = "libcap",
    srcs = glob(["libcap/cap_*.c"]) + [
        "cap_names.h",
        "libcap/libcap.h",
    ],
    hdrs = glob(["libcap/include/**/*.h"]),
    copts = [
        "-Wno-tautological-compare",
        "-Wno-unused-result",
    ],
    includes = ["libcap/include"],
    visibility = ["//visibility:public"],
)
