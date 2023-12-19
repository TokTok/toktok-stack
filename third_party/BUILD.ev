load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "ev",
    srcs = [
        "ev.c",
        "ev_vars.h",
        "ev_wrap.h",
    ],
    hdrs = ["ev.h"],
    copts = [
        "-D_DEFAULT_SOURCE",
        "-DEV_STANDALONE",
        "-Wno-bitwise-op-parentheses",
        "-Wno-comment",
        "-Wno-extern-initializer",
        "-Wno-return-type",
        "-Wno-unused",
    ],
    includes = ["."],
    textual_hdrs = [
        "ev_poll.c",
        "ev_epoll.c",
        "ev_iouring.c",
        "ev_select.c",
    ],
    visibility = ["//visibility:public"],
)
