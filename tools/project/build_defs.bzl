"""Defines a project macro used in every TokTok sub-project.

It checks constraints such as the use of the correct license and the presence
and correctness of the license text.
"""

WORKFLOWS = {
    "common": ["checks.base", "ci.base", "release.base"],
    "haskell": ["checks", "ci", "publish"],
}

_COMMON = "common"
_HASKELL = "haskell"

def _detect_language():
    if native.package_name().startswith("hs-"):
        return _HASKELL
    return _COMMON

def _workflows(language):
    workflows = {}
    for lang in [_COMMON, language]:
        for wf_file in WORKFLOWS[lang]:
            wf = wf_file[:wf_file.rfind(".")] if "." in wf_file else wf_file
            workflows[wf] = [lang, wf, wf == wf_file]
    return workflows.values()

def _workflow_test(group, workflow, verbatim, tests):
    suffix = "" if verbatim else ".base"
    yml_cur = ".github/workflows/%s.yml" % workflow
    yml_ref = "//tools/project:%s/github/workflows/%s%s.yml" % (group, workflow, suffix)
    test_name = "github_%s_test" % workflow
    tests.append(test_name)
    if verbatim:
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
    else:
        native.sh_test(
            name = test_name,
            size = "small",
            srcs = ["//hs-github-tools/tools:check-workflows"],
            args = [
                "$(location %s)" % yml_ref,
                "$(location %s)" % yml_cur,
            ],
            data = [
                yml_ref,
                yml_cur,
            ],
            tags = ["no-cross", "haskell"],
        )

def _expand_template_impl(ctx):
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

_expand_template = rule(
    attrs = {
        "package": attr.string(mandatory = True),
        "template": attr.label(
            mandatory = True,
            allow_single_file = True,
        ),
    },
    implementation = _expand_template_impl,
)

def _haskell_ci_tests(haskell_package, custom_cirrus, tests):
    _expand_template(
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
        _expand_template(
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
    language = _detect_language()

    # ci-tools is special, because it provides the release workflow, so it
    # calls itself via a local path.
    if native.package_name() != "ci-tools":
        for lang, wf, verbatim in _workflows(language):
            if native.glob([".github/workflows/%s.yml" % wf], allow_empty = True):
                _workflow_test(lang, wf, verbatim, tests)

    if language == _HASKELL:
        _haskell_project(
            custom_cirrus = custom_cirrus,
            tests = tests,
        )

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

    native.test_suite(
        name = "project_tests",
        tests = tests,
        tags = ["no-cross", "haskell"],
    )

def workspace(projects, name = "workspace"):
    native.sh_test(
        name = "git_modules_test",
        size = "small",
        srcs = ["@perl"],
        args = [
            "$(location git_modules_test.pl)",
            "$(location //:.gitmodules)",
            "$(location git-remotes)",
        ] + projects,
        data = [
            "//:.gitmodules",
            "git_modules_test.pl",
            "git-remotes",
        ],
    )

    native.test_suite(
        name = "workspace_tests",
        tests = ["//%s:project_tests" % p for p in projects],
        tags = ["no-cross", "haskell"],
    )

def mkstamp(name, hdr=None):
    if hdr:
        native.genrule(
            name = name,
            outs = [hdr],
            cmd = """$(location //tools/project:mkstamp_c.sh) %s >$@""" % native.package_name(),
            srcs = ["//tools/project:mkstamp_c.sh"],
            stamp = True,
        )
    else:
        fail("mkstamp requires a `hdr` argument")
