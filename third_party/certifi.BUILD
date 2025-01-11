load("@rules_python//python:defs.bzl", "py_library")

py_library(
    name = "certifi",
    srcs = glob(["certifi/*.py"]),
    data = ["certifi/cacert.pem"],
    visibility = ["//visibility:public"],
)
