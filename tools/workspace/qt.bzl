"""Finds local Qt installation."""

def _impl(repository_ctx):
    brew_prefix = "/usr/local/Cellar/qt/" + repository_ctx.attr.version
    repository_ctx.file(
        "BUILD",
        repository_ctx.read(
            repository_ctx.path(
                Label("@toktok//third_party:BUILD.qt"),
            ),
        ),
    )

    if repository_ctx.path("/usr/lib/x86_64-linux-gnu/qt5").exists:
        repository_ctx.symlink("/usr/lib/x86_64-linux-gnu/qt5/bin", "bin")
        repository_ctx.symlink("/usr/include/x86_64-linux-gnu/qt5", "include")
        repository_ctx.symlink("/usr/lib/x86_64-linux-gnu", "lib")
    elif repository_ctx.path(brew_prefix).exists:
        repository_ctx.symlink(brew_prefix + "/bin", "bin")
        repository_ctx.symlink(brew_prefix + "/include", "include")
        repository_ctx.symlink(brew_prefix + "/lib", "lib")
    else:
        fail("Could not find Qt installation.")

qt_repository = repository_rule(
    _impl,
    attrs = {"version": attr.string(mandatory = True)},
    configure = True,
    local = True,
)
