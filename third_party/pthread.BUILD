load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "pthread_posix",
    linkopts = ["-lpthread"],
)

cc_library(
    name = "pthread",
    visibility = ["//visibility:public"],
    deps = select({
        "@toktok//tools/config:windows": ["@pthread_w32"],
        "//conditions:default": [":pthread_posix"],
    }),
)
