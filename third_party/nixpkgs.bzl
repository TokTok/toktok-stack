"""
Hard-coded paths to Nixpkgs binaries.
"""

# 24.11

NIXOS_VERSION = "a81bbdfb658428a45c69a42aa73d4bd18127c467"
NIXOS_SHA256 = "81213096489ac0940bd5cc3541eb42c4cf01a6c9a75733ff0dcc72e980c93b10"

GHC_VERSION = "9.6.6"

# Need to add this to rpath.
GCC_LIB = "/nix/store/d7x3g6lq80jbs87cra9hhy55ad6bgqjl-gcc-12.4.0-lib/lib"

# Need to change the interpreter to the one from glibc.
LD_LINUX = "/nix/store/wn7v2vhyyyi6clcyn0s9ixvl7d4d87ic-glibc-2.40-36/lib64/ld-linux-x86-64.so.2"

# Tool to patch the binary with the above two changes.
PATCHELF = "/nix/store/9q63d382x7k2h6cc2pfsb39ar3n6f9wg-patchelf-0.15.0/bin/patchelf"
