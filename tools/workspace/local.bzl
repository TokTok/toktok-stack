"""Finds local library installation on Linux and OSX."""

def _impl(repository_ctx):
    name = repository_ctx.name
    brew_prefix = "/usr/local/Cellar/%s/%s" % (
        repository_ctx.attr.brew_name or repository_ctx.name,
        repository_ctx.attr.version,
    )

    repository_ctx.file(
        "BUILD",
        repository_ctx.read(
            repository_ctx.path(
                Label("@toktok//third_party:BUILD." + name),
            ),
        ),
    )

    if repository_ctx.path("/usr/lib/x86_64-linux-gnu/lib%s.so" % name).exists:
        repository_ctx.symlink("/usr/include", "include")
        repository_ctx.symlink("/usr/lib", "lib")
    elif repository_ctx.path(brew_prefix).exists:
        repository_ctx.symlink(brew_prefix + "/include", "include")
        repository_ctx.symlink(brew_prefix + "/lib", "lib")
    else:
        local_prefix = str(repository_ctx.path(
            Label("@toktok//third_party:%s/readme.txt" % (repository_ctx.attr.brew_name or repository_ctx.name)),
        ).dirname)
        if repository_ctx.path(local_prefix).exists:
            repository_ctx.symlink(local_prefix + "/include", "include")
            repository_ctx.symlink(local_prefix + "/libs/Win64", "lib")
        else:
            fail("Could not find %s installation." % name)

local_library_repository = repository_rule(
    _impl,
    attrs = {
        "version": attr.string(mandatory = True),
        "brew_name": attr.string(),
    },
    configure = True,
    local = True,
)
