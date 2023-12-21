load("@rules_cc//cc:defs.bzl", "cc_library")

# POSIX networking library.
#
# For Windows, we use the Winsock libraries, for everything else we assume it's
# already exposed by libc.
cc_library(
    name = "psocket",
    linkopts = select({
        "@toktok//tools/config:windows": [
            "-liphlpapi",
            "-lws2_32",
        ],
        "//conditions:default": [],
    }),
    visibility = ["//visibility:public"],
)
