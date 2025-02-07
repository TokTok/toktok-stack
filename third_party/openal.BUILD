load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library", "objc_library")

COPTS = [
    "-DAL_ALEXT_PROTOTYPES",
    "-I$(GENDIR)/third_party/openal/platform",
    "-Iexternal/openal/alc",
    "-Iexternal/openal/common",
    "-fexceptions",
] + select({
    "@toktok//tools/config:arm64": [],
    "@toktok//tools/config:x86_64": ["-msse4.1"],
})

genrule(
    name = "regen_config",
    srcs = glob(["**/*"]),
    outs = ["config.h"],
    cmd = "cmake `dirname $(location CMakeLists.txt)` && cp config.h $@",
)

genrule(
    name = "version",
    srcs = ["version.h.in"],
    outs = ["version.h"],
    cmd = "".join([
        "sed -e '",
        "s/$${LIB_VERSION}/1.20.1/;",
        "s/$${LIB_VERSION_NUM}/1,20,1,0/;",
        "s/$${GIT_BRANCH}/UNKNOWN/;",
        "s/$${GIT_COMMIT_HASH}/unknown/;",
        "' $< > $@",
    ]),
)

cc_binary(
    name = "bin2h",
    srcs = ["native-tools/bin2h.c"],
)

cc_binary(
    name = "bsincgen",
    srcs = [
        "common/win_main_utf8.h",
        "native-tools/bsincgen.c",
    ],
)

genrule(
    name = "hrtf_default",
    srcs = ["hrtf/Default HRTF.mhr"],
    outs = ["hrtf_default.h"],
    cmd = "$(location :bin2h) '$<' '$@' hrtf_default",
    tools = [":bin2h"],
)

genrule(
    name = "bsinc",
    outs = ["bsinc_inc.h"],
    cmd = "$(location :bsincgen) $@",
    tools = [":bsincgen"],
)

cc_library(
    name = "openal_generic",
    srcs = glob(
        [
            "al/*.cpp",
            "al/*.h",
            "alc/*.cpp",
            "alc/*.h",
            "alc/backends/*.h",
            "alc/effects/*.cpp",
            "alc/effects/*.h",
            "alc/filters/*.cpp",
            "alc/filters/*.h",
            "alc/mixer/*.cpp",
            "alc/mixer/*.h",
            "common/*.cpp",
            "common/*.h",
        ],
        exclude = [
            "**/*_neon.*",
        ],
    ) + [
        "alc/backends/base.cpp",
        "alc/backends/loopback.cpp",
        "alc/backends/null.cpp",
        # TODO(iphydf): Make SDL2 build under docker-sandbox and enable this.
        "alc/backends/sdl2.cpp",
        "alc/backends/wave.cpp",
        "bsinc_inc.h",
        "hrtf_default.h",
        "version.h",
    ] + select({
        "@toktok//tools/config:freebsd": [],
        "@toktok//tools/config:linux": [
            "alc/backends/alsa.cpp",
            "alc/backends/oss.cpp",
        ],
        "@toktok//tools/config:osx": [],
        "@toktok//tools/config:windows": [],
    }),
    hdrs = glob(["include/AL/*.h"]),
    copts = COPTS,
    linkopts = ["-ldl"],
    strip_include_prefix = "include",
    deps = [
        "@sdl2",
        "@toktok//third_party/openal:config",
    ] + select({
        "@toktok//tools/config:freebsd": [],
        "@toktok//tools/config:linux": ["@asound"],
        "@toktok//tools/config:osx": [],
        "@toktok//tools/config:windows": [],
    }),
)

objc_library(
    name = "openal_osx",
    srcs = [
        "alc/backends/coreaudio.cpp",
        "alc/backends/coreaudio.h",
    ],
    copts = COPTS,
    sdk_frameworks = [
        "AudioToolbox",
        "CoreAudio",
    ],
    deps = [
        ":openal_generic",
        "@toktok//third_party/openal:config",
    ],
)

alias(
    name = "openal",
    actual = select({
        "@toktok//tools/config:freebsd": ":openal_generic",
        "@toktok//tools/config:linux": ":openal_generic",
        "@toktok//tools/config:osx": ":openal_osx",
        "@toktok//tools/config:windows": ":openal_generic",
    }),
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "alrecord",
    srcs = [
        "examples/alrecord.c",
        "examples/common/alhelpers.c",
        "examples/common/alhelpers.h",
    ],
    copts = ["-D_POSIX_C_SOURCE=199309L"],
    deps = [":openal"],
)
