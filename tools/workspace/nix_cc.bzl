load("@rules_nixpkgs_cc//:cc.bzl", "nixpkgs_cc_configure")

def _nix_cc_impl(ctx):
    nixpkgs_cc_configure(
        name = "nixpkgs_cc_toolchain",
        # Match rustc/rust-bindgen's LLVM version so nixpkgs doesn't pull
        # multiple Clangs/LLVMs into the Nix store.
        attribute_path = "rustc.llvmPackages.clang",
        nix_file_content = "(import <nixpkgs> {})",
        repository = "@nixpkgs",
        register = False,
    )

nix_cc = module_extension(
    implementation = _nix_cc_impl,
)
