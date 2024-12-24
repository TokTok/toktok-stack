# TODO(iphydf): Delete this once rules_nixpkgs has a release and rules_haskell uses it.
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

_rules_nixpkgs_version = "4b193df3b1a03415db74628944beb05c3320aae3"
_rules_nixpkgs_sha256 = "de32ac22283a94ef26f4c6d60a2597b6b788e3df0a7d20a053fb926553af62c4"

def rules_nixpkgs_dependencies():
    # N.B. rules_nixpkgs was split into separate components, which need to be loaded separately
    #
    # See https://github.com/tweag/rules_nixpkgs/issues/182 for the rational

    strip_prefix = "rules_nixpkgs-%s" % _rules_nixpkgs_version

    rules_nixpkgs_url = \
        "https://github.com/tweag/rules_nixpkgs/archive/{version}.tar.gz".format(
            version = _rules_nixpkgs_version
        )

    http_archive(
        name = "io_tweag_rules_nixpkgs",
        strip_prefix = strip_prefix,
        urls = [rules_nixpkgs_url],
        sha256 = _rules_nixpkgs_sha256,
    )

    # required by rules_nixpkgs
    http_archive(
        name = "rules_nodejs",
        sha256 = "0c2277164b1752bb71ecfba3107f01c6a8fb02e4835a790914c71dfadcf646ba",
        urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/5.8.5/rules_nodejs-core-5.8.5.tar.gz"],
    )

    http_archive(
        name = "rules_nixpkgs_core",
        strip_prefix = strip_prefix + "/core",
        urls = [rules_nixpkgs_url],
        sha256 = _rules_nixpkgs_sha256,
    )

    for toolchain in ["cc", "java", "python", "go", "rust", "posix", "nodejs"]:
        http_archive(
            name = "rules_nixpkgs_" + toolchain,
            strip_prefix = strip_prefix + "/toolchains/" + toolchain,
            urls = [rules_nixpkgs_url],
            sha256 = _rules_nixpkgs_sha256,
        )
