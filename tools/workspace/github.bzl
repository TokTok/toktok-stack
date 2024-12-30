"""Abbreviations for (new_)http_archive for well-behaved GitHub repos."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", _http_archive = "http_archive")

def github_archive(name, repo, version, is_release = False, strip_prefix = "", **kwargs):
    """http_archive but for GitHub downloads.

    Args:
        name: The name of the repository.
        repo: The GitHub repository in the form "owner/repo".
        version: The version to download.
        is_release: Whether the version is a release (otherwise it's a tag or ref).
        strip_prefix: The prefix to strip from the archive.
        **kwargs: Additional arguments to pass to http_archive.
    """
    owner, repo = repo.split("/")

    if version.startswith("v"):
        version_prefix = version[1:]
    else:
        version_prefix = version

    if is_release and not strip_prefix:
        url = "https://github.com/%s/%s/releases/download/%s/%s-%s.tar.gz" % (owner, repo, version, repo, version)
    else:
        url = "https://github.com/%s/%s/archive/%s.zip" % (owner, repo, version)

    if is_release and not strip_prefix:
        full_prefix = None
    else:
        full_prefix = "%s-%s%s" % (repo, version_prefix, strip_prefix)

    _http_archive(
        name = name,
        strip_prefix = full_prefix,
        urls = [url],
        **kwargs
    )

def new_github_archive(name, **kwargs):
    """new_http_archive but for GitHub downloads."""
    if "build_file" not in kwargs and "build_file_content" not in kwargs:
        kwargs["build_file"] = "@toktok//third_party:%s.BUILD" % name
    github_archive(
        name = name,
        **kwargs
    )
