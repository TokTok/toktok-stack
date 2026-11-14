load("@rules_cc//cc:defs.bzl", "cc_library", "objc_library")

REPO_ROOT = package_relative_label(":BUILD.bazel").workspace_root

COPTS = [
    "-DSDL_VIDEO_OPENGL_EGL=0",
    "-DSDL_VIDEO_RENDER_OGL_ES2=0",
    "-DUSING_GENERATED_CONFIG_H",
]

genrule(
    name = "regen_config",
    srcs = glob(["**/*"]),
    outs = ["SDL_config.h"],
    cmd = "$(execpath configure) CC='$(CC)' && cp include/SDL_config.h $@",
    toolchains = ["@rules_cc//cc:current_cc_toolchain"],
)

HDRS = glob(
    ["include/*.h"],
    exclude = ["include/SDL_config.h"],
) + ["@toktok//third_party/sdl2:platform/SDL_config.h"]

genrule(
    name = "copy_headers",
    srcs = HDRS,
    outs = ["include/SDL2/%s" % hdr[hdr.rindex("/") + 1:] for hdr in HDRS],
    cmd = "mkdir -p $(RULEDIR)/include/SDL2 && " + " && ".join([
        "cp -f $(execpath %s) $(RULEDIR)/include/SDL2/%s" % (
            hdr,
            hdr[hdr.rindex("/") + 1:],
        )
        for hdr in HDRS
    ]),
)

cc_library(
    name = "headers",
    hdrs = [":copy_headers"] + HDRS,
    copts = COPTS,
    includes = ["include"],
    deps = ["@toktok//third_party/sdl2:config"],
)

objc_library(
    name = "sdl2_osx",
    srcs = glob([
        "src/**/*.h",
        "src/*/macosx/*.c",
        "src/*/pthread/*.c",
    ]),
    copts = COPTS + ["-Wno-deprecated-declarations"],
    non_arc_srcs = glob(
        [
            "src/**/*.m",
        ],
        exclude = [
            "**/ios/**",
            "**/iphoneos/**",
            "src/hidapi/testgui/**",
        ],
    ),
    sdk_frameworks = [
        "AppKit",
        "Carbon",
        "CoreAudio",
        "CoreVideo",
        "ForceFeedback",
        "IOKit",
        "Metal",
    ],
    textual_hdrs = ["src/thread/generic/SDL_syssem.c"],
    deps = [":headers"],
)

cc_library(
    name = "sdl2_linux",
    srcs = glob(
        [
            "src/*/steam/*.h",
            "src/*/steam/*.c",
            "src/*/linux/*.h",
            "src/*/linux/*.c",
            "src/*/linux/*.cpp",
            "src/*/pthread/*.c",
        ],
        exclude = ["src/hidapi/linux/hid.cpp"],
    ),
    hdrs = glob(["src/**/*.h"]),
    linkopts = [
        "-ldl",
        "-lpthread",
    ],
    textual_hdrs = ["src/hidapi/linux/hid.c"],
    deps = [
        ":headers",
        "@x11",
        "@xcb",
    ],
)

cc_library(
    name = "sdl2_windows",
    srcs = glob(
        [
            "src/*/steam/*.h",
            "src/*/steam/*.c",
            "src/*/windows/*.h",
            "src/*/windows/*.c",
        ],
    ),
    hdrs = glob(["src/**/*.h"]),
    deps = [
        ":headers",
    ],
)

alias(
    name = "sdl2_sysdep",
    actual = select({
        "@toktok//tools/config:freebsd": ":sdl2_freebsd",
        "@toktok//tools/config:linux": ":sdl2_linux",
        "@toktok//tools/config:osx": ":sdl2_osx",
        "@toktok//tools/config:windows": ":sdl2_windows",
    }),
)

cc_library(
    name = "sdl2",
    srcs = glob(
        [
            "src/**/*.c",
            "src/**/*.h",
        ],
        exclude = [
            "src/hidapi/libusb/*",
            "src/main/**/*",
            "src/*/linux/*",
            "src/*/macosx/*",
            "src/*/windows/*",
            "src/*/qnx/*",
            "src/*/generic/*.c",
            "src/*/pthread/*.c",
            "src/video/SDL_egl.c",
            "src/hidapi/SDL_hidapi.c",
        ],
    ),
    hdrs = [":copy_headers"] + HDRS,
    copts = COPTS + [
        "-I" + REPO_ROOT + "/src/hidapi/hidapi",
    ],
    includes = ["include"],
    visibility = ["//visibility:public"],
    deps = [
        ":sdl2_sysdep",
        "@asound",
        "@glvnd",
        "@xcb",
        "@xext",
        "@xproto",
        "@xss",
        "@xxf86vm",
    ],
)
