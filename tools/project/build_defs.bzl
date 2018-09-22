"""Defines a project macro used in every TokTok sub-project.

It checks constraints such as the use of the correct license and the presence
and correctness of the license text.
"""

def project(license = "gpl3"):
    """Adds some checks to make sure the project is uniform."""
    native.sh_test(
        name = "license_test",
        size = "small",
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
        size = "small",
        srcs = ["//tools/project:readme_test.sh"],
        args = ["$(location :README.md)"],
        data = [
            ":README.md",
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
        name = "workspace_tests",
        tests = [
            ":license_tests",
            ":readme_tests",
        ],
    )
