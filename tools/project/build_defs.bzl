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

def _workflow_test(group, workflow, tests):
    workflow_yml = "workflows/%s.yml" % workflow
    yml_cur = ".github/%s" % workflow_yml
    yml_ref = "//tools/project:%s/github/%s" % (group, workflow_yml)
    test_name = "github_%s_test" % workflow
    tests.append(test_name)
    native.sh_test(
        name = test_name,
        size = "small",
        srcs = ["@diffutils//:diff"],
        args = [
            "-u",
            "$(location %s)" % yml_cur,
            "$(location %s)" % yml_ref,
        ],
        data = [
            yml_cur,
            yml_ref,
        ],
    )

def _haskell_ci_tests(haskell_package, custom_cirrus, tests):
    for workflow in ["checks", "ci", "publish"]:
        _workflow_test("haskell", workflow, tests)

    _haskell_ci(
        name = "dockerfile",
        package = haskell_package,
        template = "//tools/project:haskell/github/docker/Dockerfile.in",
    )

    tests.append("dockerfile_test")
    native.sh_test(
        name = "dockerfile_test",
        size = "small",
        srcs = ["@diffutils//:diff"],
        args = [
            "-u",
            "$(location .github/docker/Dockerfile)",
            "$(location :dockerfile)",
        ],
        data = [
            ".github/docker/Dockerfile",
            ":dockerfile",
        ],
    )

    if not custom_cirrus:
        _haskell_ci(
            name = "cirrus_ci",
            package = haskell_package,
            template = "//tools/project:haskell/cirrus.yml.in",
        )

        tests.append("cirrus_test")
        native.sh_test(
            name = "cirrus_test",
            size = "small",
            srcs = ["@diffutils//:diff"],
            args = [
                "-u",
                "$(location .cirrus.yml)",
                "$(location :cirrus_ci)",
            ],
            data = [
                ".cirrus.yml",
                ":cirrus_ci",
            ],
        )

def _haskell_project(custom_cirrus, tests):
    haskell_package = native.package_name()[3:]
    cabal_file = haskell_package + ".cabal"

    tests.append("cabal_test")
    native.sh_test(
        name = "cabal_test",
        size = "small",
        srcs = ["//tools/project:cabal_test"],
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
        tests = tests,
    )

def project(name = "project", license = "gpl3", custom_cirrus = False):
    """Adds some checks to make sure the project is uniform.

    Args:
        name: The name of the project.
        license: The license to check for.
        custom_cirrus: Whether to skip the Cirrus CI checks.
    """
    tests = []

    if native.package_name() != "ci-tools" and native.glob([".github/workflows/*.yml"], allow_empty = True):
        _workflow_test("common", "release", tests)

    tests.append("license_test")
    native.sh_test(
        name = "license_test",
        size = "small",
        srcs = ["@diffutils//:diff"],
        args = [
            "-u",
            "$(location LICENSE)",
            "$(location //tools:LICENSE.%s)" % license,
        ],
        data = [
            "LICENSE",
            "//tools:LICENSE.%s" % license,
        ],
    )

    tests.append("readme_test")
    native.sh_test(
        name = "readme_test",
        size = "small",
        srcs = ["//tools/project:readme_test.sh"],
        args = ["$(location README.md)"],
        data = ["README.md"],
    )

    if native.package_name().startswith("hs-") and native.glob(["*.cabal"], allow_empty = True):
        _haskell_project(
            custom_cirrus = custom_cirrus,
            tests = tests,
        )

    native.test_suite(
        name = "project_tests",
        tests = tests,
    )

def workspace(projects, name = "workspace"):
    native.sh_test(
        name = "git_modules_test",
        size = "small",
        srcs = ["@perl"],
        args = [
            "$(location git_modules_test.pl)",
            "$(location gitmodules)",
            "$(location git-remotes)",
        ] + projects,
        data = [
            "git_modules_test.pl",
            "gitmodules",
            "git-remotes",
        ],
    )

    native.test_suite(
        name = "workspace_tests",
        tests = ["//%s:project_tests" % p for p in projects],
    )
