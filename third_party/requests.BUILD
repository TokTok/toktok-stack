load("@rules_python//python:defs.bzl", "py_library")

py_library(
    name = "requests",
    srcs = glob(["src/requests/*.py"]),
    imports = ["src"],
    visibility = ["//visibility:public"],
    deps = [
        "@certifi",
        "@chardet",
        "@idna",
        "@urllib3",
    ],
)
