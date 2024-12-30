load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "pthreads_win32",
    srcs = ["pthread.c"],
    hdrs = glob(["*.h"]),
    copts = [
        "-DPTW32_BUILD",
        "-Wno-single-bit-bitfield-constant-conversion",
    ],
    defines = ["PTW32_STATIC_LIB"],
    includes = ["."],
    textual_hdrs = glob(["*.c"]),
)

# Extra gymnastics here so the library doesn't get built in //third_party/...
# builds done by the toktok-stack Docker image builds.
cc_library(
    name = "pthread_w32",
    visibility = ["//visibility:public"],
    deps = select({
        "@toktok//tools/config:windows": [":pthreads_win32"],
        "//conditions:default": [],
    }),
)
