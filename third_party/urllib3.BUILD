load("@rules_python//python:defs.bzl", "py_library")

genrule(
    name = "version",
    outs = ["src/urllib3/_version.py"],
    cmd = "echo '__version__ = \"1.25.11\"' > $@",
)

py_library(
    name = "urllib3",
    srcs = glob(["src/urllib3/**/*.py"]) + [":version"],
    imports = ["src"],
    visibility = ["//visibility:public"],
)
