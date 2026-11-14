load("@rules_nixpkgs_python//:python.bzl", "nixpkgs_python_configure")

def _nix_python_impl(ctx):
    nixpkgs_python_configure(
        name = "nixpkgs_python_toolchain",
        repository = "@nixpkgs",
        python3_attribute_path = "python3",
        register = False,
    )

nix_python = module_extension(
    implementation = _nix_python_impl,
)
