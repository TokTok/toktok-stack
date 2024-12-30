"""Finds local Qt installation."""

_MSVC_VERSION = "msvc2017_64"

def _impl(repository_ctx):
    brew_prefix = "/usr/local/Cellar/qt/" + repository_ctx.attr.version
    msvc_prefix = "C:/Qt/%s/%s" % (repository_ctx.attr.version, _MSVC_VERSION)
    repository_ctx.file(
        "BUILD",
        repository_ctx.read(
            repository_ctx.path(
                Label("@toktok//third_party:qt.BUILD"),
            ),
        ),
    )

    if repository_ctx.path("/usr/lib/x86_64-linux-gnu/qt5").exists:
        repository_ctx.symlink("/usr/lib/x86_64-linux-gnu/qt5/bin", "bin")
        repository_ctx.symlink("/usr/include/x86_64-linux-gnu/qt5", "include")
        repository_ctx.symlink("/usr/lib/x86_64-linux-gnu", "lib")
    elif repository_ctx.path("/usr/local/lib/qt5").exists:
        repository_ctx.symlink("/usr/local/bin", "bin")
        repository_ctx.symlink("/usr/local/include/qt5", "include")
        repository_ctx.symlink("/usr/local/lib/qt5", "lib")
    elif repository_ctx.path(brew_prefix).exists:
        repository_ctx.symlink(brew_prefix + "/bin", "bin")
        repository_ctx.symlink(brew_prefix + "/include", "include")
        repository_ctx.symlink(brew_prefix + "/lib", "lib")
        repository_ctx.symlink(brew_prefix + "/plugins", "plugins")
    elif repository_ctx.path(msvc_prefix).exists:
        repository_ctx.symlink(msvc_prefix + "/bin", "bin")
        repository_ctx.symlink(msvc_prefix + "/include", "include")
        repository_ctx.symlink(msvc_prefix + "/lib", "lib")
        repository_ctx.symlink(msvc_prefix + "/mkspecs", "mkspecs")
        repository_ctx.symlink(msvc_prefix + "/plugins", "plugins")
        repository_ctx.symlink(msvc_prefix + "/translations", "translations")
    else:
        fail("Could not find Qt installation.")

qt_repository = repository_rule(
    _impl,
    attrs = {"version": attr.string(mandatory = True)},
    configure = True,
    local = True,
)
