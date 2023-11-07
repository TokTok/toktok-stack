"""Abbreviations for (new_)http_archive for well-behaved GitHub repos."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", _http_archive = "http_archive")

def github_archive(name, repo, version, strip_prefix="", **kwargs):
    """http_archive but for GitHub downloads."""
    owner, repo = repo.split("/")
    _http_archive(
        name = name,
        strip_prefix = "%s-%s%s" % (repo, version.replace("v", ""), strip_prefix),
        urls = ["https://github.com/%s/%s/archive/%s.zip" % (owner, repo, version)],
        **kwargs
    )

def new_github_archive(name, **kwargs):
    """new_http_archive but for GitHub downloads."""
    if "build_file" not in kwargs and "build_file_content" not in kwargs:
        kwargs["build_file"] = "@toktok//third_party:BUILD.%s" % name
    github_archive(
        name = name,
        **kwargs
    )
