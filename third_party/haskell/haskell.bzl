"""Workspace rules for importing Haskell packages."""

load("@ai_formation_hazel//tools:mangling.bzl", "hazel_workspace")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def new_cabal_package(package, sha256 = None, url = None, strip_prefix = None, patches = None):
    url = url or "https://hackage.haskell.org/package/%s/%s.tar.gz" % (package, package)
    strip_prefix = strip_prefix or package

    package_name, _ = package.rsplit("-", 1)

    http_archive(
        name = hazel_workspace(package_name),
        build_file = "@toktok//third_party/haskell:BUILD.%s" % package_name,
        patches = patches,
        sha256 = sha256,
        strip_prefix = strip_prefix,
        urls = [url],
    )
