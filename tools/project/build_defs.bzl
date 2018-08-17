"""Defines a project macro used in every TokTok sub-project.

It checks constraints such as the use of the correct license and the presence
and correctness of the license text.
"""

def project(license = "gpl3"):
    """Adds some checks to make sure the project is uniform."""
    native.sh_test(
        name = "license_test",
        srcs = ["//tools/project:license_test.sh"],
        args = [
            "$(location :LICENSE)",
            "$(location //:LICENSE.%s)" % license,
        ],
        data = [
            ":LICENSE",
            "//:LICENSE.%s" % license,
        ],
    )

    native.sh_test(
        name = "readme_test",
        srcs = ["//tools/project:readme_test.sh"],
        args = ["$(location :README.md)"],
        data = [
            ":README.md",
        ],
    )

    native.sh_test(
        name = "yamllint_test",
        srcs = ["//tools/project:yamllint_test.sh"],
        args = [
            "-c",
            "$(location //tools/project:yamllint.rc)",
            "$(location :.travis.yml)",
        ],
        data = [
            ":.travis.yml",
            "//tools/project:yamllint.rc",
        ],
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
        name = "yamllint_tests",
        tests = [":yamllint_test"] + ["//%s:yamllint_test" % p for p in projects],
    )

    native.test_suite(
        name = "workspace_tests",
        tests = [
            ":license_tests",
            ":readme_tests",
            ":yamllint_tests",
        ],
    )
