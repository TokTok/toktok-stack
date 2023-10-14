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
        tools = [_HSPEC_DISCOVER],
    )

    haskell_library(
        name = name,
        srcs = srcs + [name + "_hspec_driver"],
        src_strip_prefix = src_strip_prefix,
        **kwargs
    )

def hspec_test(name, **kwargs):
    """HSpec test."""
    srcs = native.glob(["test/*/**/*.*hs"])

    native.genrule(
        name = name + "_hspec_driver",
        srcs = srcs,
        outs = ["test/Spec.hs"],
        cmd = ";".join([
            "cd %s/test" % native.package_name(),
            "../../$(location %s) $$(basename $@) Main.hs ../../$@" % _HSPEC_DISCOVER,
        ]),
        tools = [_HSPEC_DISCOVER],
    )

    haskell_test(
        name = name,
        srcs = srcs + [name + "_hspec_driver"],
        main_file = "test/Spec.hs",
        src_strip_prefix = "test",
        **kwargs
    )
