load("@rules_python//python:defs.bzl", "py_library")

licenses(["notice"])

py_library(
    name = "python3_kivy",
    data = glob(
        ["lib/python3.14/site-packages/**"],
        exclude = [
            "**/__pycache__/**",
            "**/*.pyc",
            "**/tests/**",
            "**/*-info/**",
        ],
    ),
    imports = ["lib/python3.14/site-packages"],
    visibility = ["//visibility:public"],
)
