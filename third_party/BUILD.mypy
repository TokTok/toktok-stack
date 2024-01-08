load("@rules_python//python:defs.bzl", "py_binary", "py_library")

py_library(
    name = "mypy",
    srcs = glob(["mypy/**/*.py"]),
    data = ["mypy/typeshed/stdlib/VERSIONS"] + glob(["mypy/typeshed/**/*.pyi"]),
    visibility = ["//visibility:public"],
    deps = [
        "@mypy_extensions",
        "@typing_extensions",
    ],
)

py_binary(
    name = "bin/mypy",
    srcs = ["mypy/__main__.py"],
    main = "mypy/__main__.py",
    visibility = ["//visibility:public"],
    deps = [":mypy"],
)
