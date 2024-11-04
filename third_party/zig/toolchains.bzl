"""
Toolchain definitions for Zig.
"""

load("@rules_zig//zig:toolchain.bzl", "zig_target_toolchain")
load("//third_party:nixpkgs.bzl", "LD_LINUX")

CPUS = {
    "aarch64": {
        "cpu": "arm64",
        "dynamic_linker": None,
    },
    "x86_64": {
        "cpu": "x86_64",
        "dynamic_linker": LD_LINUX,
    },
}

def zig_nix_toolchains(name = "zig_nix_toolchains"):
    """
    Define toolchains for each supported CPU.

    Args:
        name: The name of the rule (unused).
    """
    for arch in CPUS:
        native.platform(
            name = arch + "-linux-gnu",
            constraint_values = [
                "@platforms//os:linux",
                "@platforms//cpu:" + CPUS[arch]["cpu"],
            ],
        )

        zig_target_toolchain(
            name = arch + "-linux-nix_target",
            dynamic_linker = CPUS[arch]["dynamic_linker"],
            target = arch + "-linux-gnu.2.34",
        )

        native.toolchain(
            name = arch + "-linux-nix_toolchain",
            target_compatible_with = [
                "@platforms//os:linux",
                "@platforms//cpu:" + CPUS[arch]["cpu"],
            ],
            toolchain = arch + "-linux-nix_target",
            toolchain_type = "@rules_zig//zig/target:toolchain_type",
        )
