"""Defines a project macro used in every TokTok sub-project.

It checks constraints such as the use of the correct license and the presence
and correctness of the license text.
"""

def _haskell_travis_impl(ctx):
    ctx.actions.expand_template(
        template = ctx.file._template,
        output = ctx.outputs.source_file,
        substitutions = {
            "{PACKAGE}": ctx.attr.package,
        },
    )

    outs = [ctx.outputs.source_file]
    return DefaultInfo(files = depset(outs), runfiles = ctx.runfiles(files = outs))

_haskell_travis = rule(
    attrs = {
        "package": attr.string(mandatory = True),
        "_template": attr.label(
            default = Label("//tools/project:haskell_travis.yml.in"),
            allow_single_file = True,
        ),
    },
    outputs = {"source_file": ".travis-expected.yml"},
    implementation = _haskell_travis_impl,
)

def _haskell_project(standard_travis):
    haskell_package = native.package_name()[3:]
    cabal_file = haskell_package + ".cabal"
    native.sh_test(
        name = "cabal_test",
        size = "small",
        srcs = ["//tools/project:cabal_test.pl"],
        args = [
            "$(location BUILD.bazel)",
            "$(location %s)" % cabal_file,
        ],
        data = [
            "BUILD.bazel",
            cabal_file,
        ],
    )

    if standard_travis:
        _haskell_travis(
            name = "travis",
            package = haskell_package,
        )

        native.sh_test(
            name = "travis_test",
            size = "small",
            srcs = ["//tools/project:diff_test.sh"],
            data = [
                ".travis.yml",
                ":travis",
            ],
            args = [
                "$(location .travis.yml)",
                "$(location :travis)",
            ],
        )

def project(license = "gpl3", standard_travis = False):
    """Adds some checks to make sure the project is uniform."""
    native.sh_test(
        name = "license_test",
        size = "small",
        srcs = ["//tools/project:diff_test.sh"],
        args = [
            "$(location LICENSE)",
            "$(location //:LICENSE.%s)" % license,
        ],
        data = [
            "LICENSE",
            "//:LICENSE.%s" % license,
        ],
    )

    native.sh_test(
        name = "readme_test",
        size = "small",
        srcs = ["//tools/project:readme_test.sh"],
        args = ["$(location README.md)"],
        data = ["README.md"],
    )

    if (native.package_name().startswith("hs-") and
        any([f for f in native.glob(["*"]) if f.endswith(".cabal")])):
        _haskell_project(
            standard_travis = standard_travis,
        )

def workspace(projects):
    project()

    native.test_suite(
        name = "license_tests",
        tests = [":license_test"] + ["//%s:license_test" % p for p in projects],
    )

    native.test_suite(
        name = "readme_tests",
        tests = [":readme_test"] + ["//%s:readme_test" % p for p in projects],
    )

    native.test_suite(
        name = "workspace_tests",
        tests = [
            ":license_tests",
            ":readme_tests",
        ],
    )
