load("@rules_cc//cc:defs.bzl", "cc_library")

genrule(
    name = "regen_config",
    srcs = glob([
        "**/*.am",
        "**/*.in",
        "**/*.m4",
        "libexif/*/Makefile-files",
    ]) + [
        "AUTHORS",
        "COPYING",
        "ChangeLog",
        "NEWS",
        "README",
        "configure.ac",
        "libexif/exif-data.h",
    ],
    outs = ["config.h"],
    cmd = """
        BASE=`pwd`
        export PATH="$$PATH:$$BASE/$$(dirname $(location @autoconf//:autoconf))"
        export PATH="$$PATH:$$BASE/$$(dirname $(location @automake//:aclocal))"
        export PATH="$$PATH:$$BASE/$$(dirname $(location @diffutils//:cmp))"
        export PATH="$$PATH:$$BASE/$$(dirname $(location @gettext//:bin/autopoint))"
        export PATH="$$PATH:$$BASE/$$(dirname $(location @libtool//:libtoolize))"
        export PATH="$$PATH:$$BASE/$$(dirname $(location @m4))"
        export PATH="$$PATH:$$BASE/$$(dirname $(location @xz//:bin/xz))"
        SRCDIR="$$(dirname $(location configure.ac))"
        autoreconf -fi -I "$$PWD/$$(dirname $(location @libtool//:libtool.m4))" "$$SRCDIR"

        cd "$$SRCDIR"
        ./configure CC="$(CC)" AR="$(AR)" MAKE="$$BASE/$(location @gnumake)" || (cat config.log && false)
        DIR=`pwd`
        cd -
        for i in $(OUTS); do
          cp $$DIR/`echo $$i | sed -e 's|$(GENDIR)/external/libexif/||'` $$i
        done
    """,
    toolchains = ["@rules_cc//cc:current_cc_toolchain"],
    tools = [
        "@autoconf",
        "@autoconf//:autoreconf",
        "@automake",
        "@automake//:aclocal",
        "@diffutils//:cmp",
        "@gettext//:bin/autopoint",
        "@gnumake",
        "@libtool//:libtool.m4",
        "@libtool//:libtoolize",
        "@m4",
        "@xz//:bin/xz",
    ],
)

genrule(
    name = "_stdint_h",
    outs = ["libexif/_stdint.h"],
    cmd = "echo '#include <stdint.h>' > $@",
)

cc_library(
    name = "libexif",
    srcs = glob([
        "libexif/**/*.c",
        "libexif/**/*.h",
    ]),
    hdrs = [
        "libexif/_stdint.h",
        "libexif/exif.h",
        "libexif/exif-loader.h",
    ],
    copts = [
        "-w",  # disable all warnings.
        "-D_POSIX_C_SOURCE",  # localtime_r
        "-DLOCALEDIR='\"lib\"'",
        "-DGETTEXT_PACKAGE='\"libexif\"'",
        "-Ithird_party/libexif",
        "-I$(GENDIR)/third_party/libexif/platform",
    ],
    includes = ["."],
    visibility = ["//visibility:public"],
    deps = [
        #"@gettext",
        "@toktok//third_party/libexif:config",
    ],
)
