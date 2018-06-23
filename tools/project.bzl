"""Defines a project macro used in every TokTok sub-project.

It checks constraints such as the use of the correct license and the presence
and correctness of the license text.
"""

def project(name):
    """Adds some checks to make sure the project is uniform."""
    pkg = native.package_name()
    pkg = pkg.replace("_", "-")

    if name != pkg:
        fail("expected project name was '%s', but was set to '%s'" % (pkg, name))

    native.sh_test(
        name = "license_test",
        srcs = ["//tools/project:license_test.sh"],
        args = [
            "$(location :LICENSE.md)",
            "$(location //:LICENSE.md)",
        ],
        data = [
            ":LICENSE.md",
            "//:LICENSE.md",
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
