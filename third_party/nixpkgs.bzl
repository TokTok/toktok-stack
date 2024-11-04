"""
Hard-coded paths to Nixpkgs binaries.
"""

# 23.11

NIXOS_VERSION = "23.11"
NIXOS_SHA256 = "bc9a0a74e8d7fb0e11434dd3abaa0cb0572ccd3a65b5a192eea41832b286e8a0"

GHC_VERSION = "9.4.8"

# Need to add this to rpath.
GCC_LIB = "/nix/store/myw67gkgayf3s2mniij7zwd79lxy8v0k-gcc-12.3.0-lib/lib"

# Need to change the interpreter to the one from glibc.
LD_LINUX = "/nix/store/qn3ggz5sf3hkjs2c797xf7nan3amdxmp-glibc-2.38-27/lib64/ld-linux-x86-64.so.2"

# Tool to patch the binary with the above two changes.
PATCHELF = "/nix/store/85jldj870vzcl72yz03labc93bwvqayx-patchelf-0.15.0/bin/patchelf"

# # 24.05

# NIXOS_VERSION = "24.05"
# NIXOS_SHA256 = "911314b81780f26fdaf87e17174210bdbd40c86bac1795212f257cdc236a1e78"

# GHC_VERSION = "9.6.5"

# # Need to add this to rpath.
# GCC_LIB = "/nix/store/d4dzkmwkyrkc1l8z9x7vcdj193fx4g45-gcc-12.3.0-lib/lib"

# # Need to change the interpreter to the one from glibc.
# LD_LINUX = "/nix/store/k7zgvzp2r31zkg9xqgjim7mbknryv6bs-glibc-2.39-52/lib64/ld-linux-x86-64.so.2"

# # Tool to patch the binary with the above two changes.
# PATCHELF = "/nix/store/nbad47q0m0m9c5xid7zh05hiknwircbp-patchelf-0.15.0/bin/patchelf"
