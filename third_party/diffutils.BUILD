alias(
    name = "cmp",
    actual = "bin/cmp",
    visibility = ["//visibility:public"],
)

alias(
    name = "diff",
    actual = "bin/diff",
    visibility = ["//visibility:public"],
)

filegroup(
    name = "diffutils",
    srcs = [
        ":cmp",
        ":diff",
    ],
    visibility = ["//visibility:public"],
)
