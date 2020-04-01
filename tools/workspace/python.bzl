"""Finds local system Python headers and libraries

Uses python-config to make them available to be used as a C/C++ dependency.

Example:
    WORKSPACE:
        load("//tools/workspace:python.bzl", "python_repository")
        python_repository(
            name = "python3",
            version = "3",
        )

    BUILD:
        cc_library(
            name = "foobar",
            srcs = ["bar.cc"],
            deps = ["@python2//:python"],
        )

Arguments:
    name: A unique name for this rule.
    version: The version of Python headers and libraries to be found.
"""

def _python_config(repository_ctx, versions):
    for version in versions:
        python_config = repository_ctx.which("python{}-config".format(version))

        if not python_config:
            continue

        result = repository_ctx.execute([python_config, "--help"])
        if result.return_code == 0:
            return python_config

    return None

def _impl(repository_ctx):
    version = repository_ctx.attr.version
    if "." in version:
        versions = [repository_ctx.attr.version]
    elif version == "2":
        versions = ["2.7"]
    elif version == "3":
        versions = ["3.8", "3.7", "3.6", "3.5"]

    python_config = _python_config(repository_ctx, versions)

    if not python_config:
        fail("Could not find pythonX-config for X in {}".format(versions))

    result = repository_ctx.execute([python_config, "--includes"])

    if result.return_code != 0:
        fail("Could not determine Python includes", attr = result.stderr)

    cflags = result.stdout.strip().split(" ")
    cflags = [cflag for cflag in cflags if cflag]

    root = repository_ctx.path("")
    root_len = len(str(root)) + 1
    base = root.get_child("include")

    includes = []

    for cflag in cflags:
        if cflag.startswith("-I"):
            source = repository_ctx.path(cflag[2:])
            destination = base.get_child(str(source).replace("/", "_"))
            include = str(destination)[root_len:]

            if include not in includes:
                repository_ctx.symlink(source, destination)
                includes.append(include)

    result = repository_ctx.execute([python_config, "--ldflags"])

    if result.return_code != 0:
        fail("Could NOT determine Python linkopts", attr = result.stderr)

    linkopts = result.stdout.strip().split(" ")
    linkopts = [linkopt for linkopt in linkopts if linkopt]

    for i in reversed(range(len(linkopts))):
        if not linkopts[i].startswith("-"):
            linkopts[i - 1] = " ".join([linkopts[i - 1], linkopts.pop(i)])

    file_content = """
cc_library(
    name = "python",
    hdrs = glob(["include/**"]),
    includes = {},
    linkopts = {},
    visibility = ["//visibility:public"],
)
  """.format(includes, linkopts)

    repository_ctx.file(
        "BUILD",
        content = file_content,
        executable = False,
    )

python_repository = repository_rule(
    _impl,
    attrs = {"version": attr.string(default = "3")},
    configure = True,
    local = True,
)
