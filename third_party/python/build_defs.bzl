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
load("@rules_python//python:defs.bzl", "py_library")

def pyx_library(
        name,
        cdeps = [],
        srcs = [],
        cython_directives = {},
        cython_options = [],
        tags = [],
        copts = [],
        **kwargs):
    # First filter out files that should be run compiled vs. passed through.
    py_srcs = []
    pyx_srcs = []
    pxd_srcs = []
    for src in srcs:
        if src.endswith(".pyx") or (
            src.endswith(".py") and src[:-3] + ".pxd" in srcs
        ):
            pyx_srcs.append(src)
        elif src.endswith(".py"):
            py_srcs.append(src)
        else:
            pxd_srcs.append(src)

    # Invoke cython to generate C code.
    extra_flags = " ".join(
        ["-X '%s=%s'" % x for x in cython_directives.items()] +
        cython_options + ["-Werror", "-Wextra", "--line-directives"],
    )

    native.genrule(
        name = name + "_cythonize",
        srcs = pyx_srcs + pxd_srcs,
        outs = [src.split(".")[0] + ".c" for src in pyx_srcs],
        cmd = "\n".join([
            "PYTHONHASHSEED=0 $(location @cython//:cython) -I %s -I $(GENDIR)/%s %s %s" % (
                native.package_name(),
                native.package_name(),
                extra_flags,
                " ".join(["$(location %s)" % s for s in pyx_srcs]),
            ),
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
            srcs = [base + ".c"],
            copts = copts,
            linkshared = True,
            tags = tags,
            deps = ["@python3//:python"] + cdeps,
        )

    # Finally, create a py_library with these shared objects as data.
    py_library(
        name = name,
        srcs = py_srcs,
        data = bins + pyx_srcs + pxd_srcs,
        imports = ["."],
        tags = tags,
        **kwargs
    )
