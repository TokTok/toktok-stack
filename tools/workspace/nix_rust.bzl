load("@rules_nixpkgs_rust//:rust.bzl", "nixpkgs_rust_configure")
load("@rules_nixpkgs_core//:nixpkgs.bzl", "nixpkgs_package")

def _nix_rust_impl(ctx):
    nixpkgs_rust_configure(
        name = "nixpkgs_rust",
        repository = "@nixpkgs",
        default_edition = "2021",
        register = False,
    )

    nixpkgs_package(
        name = "nixpkgs_libclang",
        repository = "@nixpkgs",
        attribute_path = "rustc.llvmPackages.libclang.lib",
        build_file_content = """
load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "libclang",
    srcs = glob(["lib/libclang.so*", "lib/libclang.dylib*"], allow_empty = True),
    visibility = ["//visibility:public"],
)
""",
    )

    # Tools built on the compiler (rustc_private) link against rustc's own
    # library and the LLVM that rustc was built with.
    nixpkgs_package(
        name = "nixpkgs_librustc_driver",
        repository = "@nixpkgs",
        attribute_path = "rustc.unwrapped",
        build_file_content = """
load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "librustc_driver",
    srcs = glob(["lib/librustc_driver-*.so"]),
    visibility = ["//visibility:public"],
)
""",
    )

    nixpkgs_package(
        name = "nixpkgs_libllvm",
        repository = "@nixpkgs",
        attribute_path = "rustc.llvmPackages.llvm.lib",
        build_file_content = """
load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "libllvm",
    srcs = glob(["lib/libLLVM*.so*"]),
    visibility = ["//visibility:public"],
)
""",
    )

    nixpkgs_package(
        name = "nixpkgs_bindgen",
        repository = "@nixpkgs",
        attribute_path = "rust-bindgen",
        build_file_content = """
load("@rules_rust_bindgen//:defs.bzl", "rust_bindgen_toolchain")

filegroup(
    name = "bindgen_bin",
    srcs = ["bin/bindgen"],
    visibility = ["//visibility:public"],
)

rust_bindgen_toolchain(
    name = "bindgen_toolchain",
    bindgen = ":bindgen_bin",
    libclang = "@nixpkgs_libclang//:libclang",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "toolchain",
    toolchain = ":bindgen_toolchain",
    toolchain_type = "@rules_rust_bindgen//:toolchain_type",
)
""",
    )

nix_rust = module_extension(
    implementation = _nix_rust_impl,
)
