"""Defines a project macro used in every TokTok sub-project.

It checks constraints such as the use of the correct license and the presence
and correctness of the license text.
"""

def _haskell_ci_impl(ctx):
    output = ctx.actions.declare_file(ctx.attr.name + ".expected")
    ctx.actions.expand_template(
        template = ctx.file.template,
        output = output,
        substitutions = {
            "{PACKAGE}": ctx.attr.package,
        },
    )

    outs = [output]
    return DefaultInfo(files = depset(outs), runfiles = ctx.runfiles(files = outs))

_haskell_ci = rule(
    attrs = {
        "package": attr.string(mandatory = True),
        "template": attr.label(
            mandatory = True,
            allow_single_file = True,
        ),
    },
    implementation = _haskell_ci_impl,
)

def _haskell_ci_tests(haskell_package, custom_cirrus, custom_github):
    if not custom_github and native.glob([".github/workflows/ci.yml"], allow_empty = True):
        native.sh_test(
            name = "github_ci_test",
            size = "small",
            srcs = ["//tools/project:diff_test.sh"],
            data = [
                ".github/workflows/ci.yml",
                "//tools/project:haskell_ci.yml.in",
            ],
            args = [
                "$(location .github/workflows/ci.yml)",
                "$(location //tools/project:haskell_ci.yml.in)",
            ],
        )

    if not custom_cirrus:
        _haskell_ci(
            name = "cirrus_ci",
            package = haskell_package,
            template = "//tools/project:haskell_cirrus.yml.in",
        )

        native.sh_test(
            name = "cirrus_test",
            size = "small",
            srcs = ["//tools/project:diff_test.sh"],
            data = [
                ".cirrus.yml",
                ":cirrus_ci",
            ],
            args = [
                "$(location .cirrus.yml)",
                "$(location :cirrus_ci)",
            ],
        )

def _haskell_project(custom_cirrus, custom_github):
    haskell_package = native.package_name()[3:]
    cabal_file = haskell_package + ".cabal"
    native.sh_test(
        name = "cabal_test",
        size = "small",
        srcs = ["//tools/project:cabal_test.py"],
        args = [
            "$(location BUILD.bazel)",
            "$(location %s)" % cabal_file,
        ],
        data = [
            "BUILD.bazel",
            cabal_file,
        ],
    )

    _haskell_ci_tests(
        haskell_package = haskell_package,
        custom_cirrus = custom_cirrus,
        custom_github = custom_github,
    )

def project(license = "gpl3", custom_cirrus = False, custom_github = False):
    """Adds some checks to make sure the project is uniform."""
    native.sh_test(
        name = "license_test",
        size = "small",
        srcs = ["//tools/project:diff_test.sh"],
        args = [
            "$(location LICENSE)",
            "$(location //tools:LICENSE.%s)" % license,
        ],
        data = [
            "LICENSE",
            "//tools:LICENSE.%s" % license,
        ],
    )

    native.sh_test(
        name = "readme_test",
        size = "small",
        srcs = ["//tools/project:readme_test.sh"],
        args = ["$(location README.md)"],
        data = ["README.md"],
    )

    native.sh_test(
        name = "settings_test",
        size = "small",
        srcs = ["//tools/project:settings_test.sh"],
        args = [
            "$(location .github/settings.yml)",
            # qTox is an exception. Maybe we should rename the submodule?
            "qTox" if native.package_name() == "qtox" else native.package_name().replace("_", "-"),
        ],
        data = [".github/settings.yml"],
    )

    if native.package_name().startswith("hs-") and native.glob(["*.cabal"], allow_empty = True):
        _haskell_project(
            custom_cirrus = custom_cirrus,
            custom_github = custom_github,
        )

def workspace(projects):
    native.sh_test(
        name = "git_modules_test",
        size = "small",
        srcs = [":git_modules_test.pl"],
        args = [
            "$(location gitmodules)",
            "$(location git-remotes)",
        ] + projects,
        data = [
            "gitmodules",
            "git-remotes",
        ],
    )

    native.test_suite(
        name = "license_tests",
        tests = ["//%s:license_test" % p for p in projects],
    )

    native.test_suite(
        name = "readme_tests",
        tests = ["//%s:readme_test" % p for p in projects],
    )

    native.test_suite(
        name = "settings_tests",
        tests = ["//%s:settings_test" % p for p in projects],
    )

    native.test_suite(
        name = "workspace_tests",
        tests = [
            ":license_tests",
            ":readme_tests",
            ":settings_tests",
        ],
    )
