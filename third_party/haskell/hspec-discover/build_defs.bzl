"""HSpec test rules."""

load("@rules_haskell//haskell:defs.bzl", "haskell_library", "haskell_test")

_HSPEC_DISCOVER = "@haskellPackages.hspec-discover//:hspec-discover"

def hspec_library(name, src_strip_prefix, **kwargs):
    """HSpec test library.

    Args:
      name: Rule name.
      src_strip_prefix: Prefix to remove from source paths when constructing the module name.
      **kwargs: Other arguments to pass to haskell_library.
    """
    srcs = native.glob(["%s/*/**/*.*hs" % src_strip_prefix])
    relpath = "/".join([".." for _ in src_strip_prefix.split("/")])
    module_name = "ToxTestSuite"

    native.genrule(
        name = name + "_hspec_driver",
        srcs = srcs,
        outs = [name + "_hspec_driver.hs"],
        cmd = ";".join([
            "cd %s/src/testsuite" % native.package_name(),
            "../{relpath}/$(location {discover}) $$(basename $@) $$(basename $@) ../{relpath}/$@ --module-name={module_name}".format(
                discover = _HSPEC_DISCOVER,
                relpath = relpath,
                module_name = module_name,
            ),
        ]),
        tags = ["haskell"],
        tools = [_HSPEC_DISCOVER],
    )

    haskell_library(
        name = name,
        srcs = srcs + [name + "_hspec_driver"],
        src_strip_prefix = src_strip_prefix,
        tags = ["haskell"],
        **kwargs
    )

def hspec_test(name, srcs=None, visibility=["//tools/haskell:__pkg__"], **kwargs):
    """HSpec test."""
    if not srcs:
        srcs = native.glob(["test/*/**/*.*hs"])

    driver_file = "test/%s_Spec.hs" % name

    # From the package's test directory back to the execution root.
    up = "/".join([".." for _ in native.package_name().split("/")] + [".."])

    native.genrule(
        name = name + "_hspec_driver",
        srcs = srcs,
        outs = [driver_file],
        cmd = ";".join([
            "cd %s/test" % native.package_name(),
            "{up}/$(location {discover}) $$(basename $@) Main.hs {up}/$@".format(up = up, discover = _HSPEC_DISCOVER),
        ]),
        tags = ["haskell"],
        tools = [_HSPEC_DISCOVER],
    )

    haskell_test(
        name = name,
        srcs = srcs + [name + "_hspec_driver"],
        main_file = driver_file,
        src_strip_prefix = "test",
        tags = ["haskell"],
        visibility = visibility,
        **kwargs
    )
