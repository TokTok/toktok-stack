"""Defines a project macro used in every TokTok sub-project.

It checks constraints such as the use of the correct license and the presence
and correctness of the license text.
"""

WORKFLOWS = {
    "common": [
        "github/ISSUE_TEMPLATE/release.yml.base",
        "github/workflows/checks.yml.base",
        "github/workflows/ci.yml.base",
        "github/workflows/draft.yml.base",
        "github/workflows/release.yml.base",
        "reviewable/completion.js",
        "reviewable/settings.yaml",
    ],
    "haskell": [
        "github/workflows/checks.yml",
        "github/workflows/ci.yml",
        "github/workflows/publish.yml",
    ],
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
            cur = wf_file.removesuffix(".base")
            workflows[cur] = struct(
                language=lang,
                ref=wf_file,
                cur="." + cur,
                type=cur.split("/")[1],
                verbatim=not wf_file.endswith(".base"),
            )
    return workflows.values()

def _workflow_test(wf, cur):
    ref = "//tools/project:%s/%s" % (wf.language, wf.ref)
    if wf.verbatim:
        test_name = "%s_diff_test" % (wf.ref.replace("/", "_").replace(".", "_").lower())
        native.sh_test(
            name = test_name,
            size = "small",
            srcs = ["@diffutils//:diff"],
            args = [
                "-u",
                "$(location %s)" % cur,
                "$(location %s)" % ref,
            ],
            data = [
                cur,
                ref,
            ],
        )
    else:
        test_name = "%s_test" % wf.ref.replace("/", "_").replace(".", "_").lower()
        native.sh_test(
            name = test_name,
            size = "small",
            srcs = ["//hs-github-tools/tools:check-workflows"],
            args = [
                wf.type,
                "$(location %s)" % ref,
                "$(location %s)" % cur,
            ],
            data = [
                ref,
                cur,
            ],
            tags = ["no-cross", "haskell"],
        )
    return test_name

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

    for wf in _workflows(language):
        if native.package_name() == "ci_tools" and wf.ref.startswith("github/workflows/"):
            # ci-tools is special, because it provides the release workflow, so
            # it calls itself via a local path.
            continue
        cur = native.glob([wf.cur, wf.cur.replace(".yml", ".yaml")], allow_empty = True)
        if cur:
            tests.append(_workflow_test(wf, cur[0]))

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

def mkstamp(name, src, out):
    native.genrule(
        name = name,
        outs = [out],
        cmd = """$(location //tools/project:mkstamp_c.sh) %s $(location %s) >'$@'""" % (native.package_name(), src),
        srcs = ["//tools/project:mkstamp_c.sh", src],
        stamp = True,
    )
