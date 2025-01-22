load("@rules_cc//cc:defs.bzl", "cc_library")

genrule(
    name = "regen_config",
    srcs = [
        "Makefile.in",
        "backtrace.h",
        "backtrace-supported.h.in",
        "config.guess",
        "config.h.in",
        "config.sub",
        "configure",
        "install-debuginfo-for-buildid.sh.in",
        "install-sh",
        "missing",
    ],
    outs = [
        "backtrace-supported.h",
        "config.h",
    ],
    cmd = """
        SRCDIR="$$(dirname $(location configure))"
        "$$SRCDIR/configure" CC="$(CC)" AR="$(AR)" LD="$(CC)" \
            || (cat config.log && false)
        sed -i -e 's/#define BACKTRACE_ELF_SIZE unused/#define BACKTRACE_ELF_SIZE 64/' config.h

        cp "backtrace-supported.h" "$(location backtrace-supported.h)"
        cp "config.h" "$(location config.h)"
    """,
    toolchains = ["@rules_cc//cc:current_cc_toolchain"],
)

cc_library(
    name = "libbacktrace",
    srcs = [
        "alloc.c",
        "atomic.c",
        "backtrace.c",
        "backtrace.h",
        "dwarf.c",
        "elf.c",
        "fileline.c",
        "filenames.h",
        "internal.h",
        "posix.c",
        "print.c",
        "read.c",
        "sort.c",
        "state.c",
        "@toktok//third_party/libbacktrace:config",
    ],
    copts = ["-I$(GENDIR)/third_party/libbacktrace"],
    visibility = ["//visibility:public"],
)
