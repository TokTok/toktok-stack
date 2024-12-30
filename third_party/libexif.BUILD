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
        cd `dirname $(location configure.ac)`
        autoreconf -fi
        ./configure
        DIR=`pwd`
        cd -
        for i in $(OUTS); do
          cp $$DIR/`echo $$i | sed -e 's|$(GENDIR)/external/libexif/||'` $$i
        done
    """,
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
