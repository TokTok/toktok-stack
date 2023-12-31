load("@rules_zig//zig:toolchain.bzl", "zig_target_toolchain")

CPUS = {
    "aarch64": {
        "cpu": "arm64",
        "dynamic_linker": None,
    },
    "x86_64": {
        "cpu": "x86_64",
        "dynamic_linker": "/nix/store/qn3ggz5sf3hkjs2c797xf7nan3amdxmp-glibc-2.38-27/lib/ld-linux-x86-64.so.2",
    },
}

def zig_nix_toolchains():
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
