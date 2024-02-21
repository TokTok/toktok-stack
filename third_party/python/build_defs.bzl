"""
Defines a pyx_library() macros corresponding to py_library.

Uses Cython to compile .pyx files (and .py files with corresponding .pxd
files) to Python extension modules.

Example:

load("//third_party/python:build_defs.bzl", "pyx_library")

pyx_library(
    name = "mylib",
    srcs = ["mylib.pyx"],
    # C library deps passed to cc_binary
    cdeps = ["//cc_library/dep"],
    # python library deps passed to py_library
    deps = ["//py_library/dep"],
)
"""

load("@rules_cc//cc:defs.bzl", "cc_binary")
load("@rules_python//python:defs.bzl", "py_library", "py_test")

def pyx_library(
        name,
        cdeps = [],
        srcs = [],
        data = [],
        cython_directives = {},
        cython_options = [],
        tags = [],
        copts = [],
        **kwargs):
    # First filter out files that should be run compiled vs. passed through.
    py_srcs = []
    pyi_srcs = []
    pyx_srcs = []
    pxd_srcs = []
    for src in srcs:
        if src.endswith(".pyx") or (
            src.endswith(".py") and src[:-3] + ".pxd" in srcs
        ):
            pyx_srcs.append(src)
        elif src.endswith(".pyi"):
            pyi_srcs.append(src)
        elif src.endswith(".py"):
            py_srcs.append(src)
        else:
            pxd_srcs.append(src)

    # Invoke cython to generate C code.
    extra_flags = " ".join(
        ["-X '%s=%s'" % x for x in cython_directives.items()] +
        cython_options + ["-Werror", "-Wextra", "--line-directives", "--gdb"],
    )

    cpp_srcs = ["%s.cpp" % src.split(".")[0] for src in pyx_srcs]
    debug_info = ["cython_debug/cython_debug_info_%s" % src.split(".")[0].split("/")[-1] for src in pyx_srcs]
    native.genrule(
        name = name + "_cythonize",
        srcs = pyx_srcs + pxd_srcs,
        outs = cpp_srcs + debug_info,
        cmd = "\n".join([
            "PYTHONHASHSEED=0 $(location @cython//:cython) --cplus -I %s -I $(GENDIR)/%s %s %s" % (
                native.package_name(),
                native.package_name(),
                extra_flags,
                " ".join(["$(location %s)" % s for s in pyx_srcs]),
            ),
            "cp -r cython_debug $(RULEDIR)",
            "cp -r %s/* $(RULEDIR)" % native.package_name(),
        ]),
        tags = tags,
        tools = ["@cython//:cython"],
    )

    # Compile the C code to shared objects.
    bins = []
    for src in pyx_srcs:
        base = src.split(".")[0]
        bins.append(base + ".so")
        cc_binary(
            name = bins[-1],
            srcs = [base + ".cpp"],
            copts = copts,
            linkshared = True,
            tags = tags,
            deps = ["@python3//:python"] + cdeps,
        )

    # Finally, create a py_library with these shared objects as data.
    py_library(
        name = name,
        srcs = py_srcs,
        data = bins + pyx_srcs + pxd_srcs + pyi_srcs + data,
        imports = ["."],
        tags = tags,
        **kwargs
    )

def mypy_test(name, srcs, deps = [], path = [], tags = []):
    py_test(
        name = name,
        size = "small",
        srcs = ["//third_party/python:mypy_test.py"],
        args = [
            "--extra-checks",
            "--strict",
        ] + ["$(location :%s)" % s for s in srcs],
        data = srcs,
        env = {"MYPYPATH": ":".join(path)},
        tags = tags,
        deps = deps + ["@mypy"],
    )
