workspace(name = "toktok")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//tools/workspace:github.bzl", "github_archive", "new_github_archive")

github_archive(
    name = "bazel_skylib",
    repo = "bazelbuild/bazel-skylib",
    sha256 = "19a99bc16079c8853f96d50e627afa158aa00bf52460f45f923466105ff8fe13",
    version = "1.5.0",
)

# Third-party Bazel
# =========================================================

# https://github.com/uber/hermetic_cc_toolchain
github_archive(
    name = "hermetic_cc_toolchain",
    repo = "uber/hermetic_cc_toolchain",
    sha256 = "c35f6e2110cdb147964fabe94fad6d30749d7b9d853cc8cb24890a9269d4153b",
    version = "v2.1.3",
)

# hermetic_cc_toolchain
load("@hermetic_cc_toolchain//toolchain:defs.bzl", zig_toolchains = "toolchains")

zig_toolchains()

# Actual zig toolchain (the above is for C/C++)
# =========================================================

# Run before adding the default toolchains below, so this one gets used first.
register_toolchains(
    "//third_party/zig:aarch64-linux-nix_toolchain",
    "//third_party/zig:x86_64-linux-nix_toolchain",
)

github_archive(
    name = "rules_zig",
    repo = "aherrmann/rules_zig",
    sha256 = "c89162afd5d78591d9ffd1e22a386feeb9e26f185b982f619d5c7b0aaf3f15ad",
    version = "0363e3f65dae45cb29c76d457cb8a4bd4654604c",
)

load(
    "@rules_zig//zig:repositories.bzl",
    "rules_zig_dependencies",
    "zig_register_toolchains",
)

rules_zig_dependencies()

zig_register_toolchains(
    name = "zig",
    zig_version = "0.11.0",
)

# Fuzzing
# =========================================================

github_archive(
    name = "rules_fuzzing",
    repo = "bazelbuild/rules_fuzzing",
    sha256 = "ff52ef4845ab00e95d29c02a9e32e9eff4e0a4c9c8a6bcf8407a2f19eb3f9190",
    version = "v0.4.1",
)

load("@rules_fuzzing//fuzzing:repositories.bzl", "rules_fuzzing_dependencies")

rules_fuzzing_dependencies()

load("@rules_fuzzing//fuzzing:init.bzl", "rules_fuzzing_init")

rules_fuzzing_init()

load("@fuzzing_py_deps//:requirements.bzl", "install_deps")

install_deps()

# Go
# =========================================================

github_archive(
    name = "io_bazel_rules_go",
    repo = "bazelbuild/rules_go",
    sha256 = "82f7ae1c9ffcfde827f4164123a6775c5c28d9993d291e4fd40bf40698926569",
    version = "v0.41.0",
    # TODO(https://github.com/tweag/rules_nixpkgs/pull/422): Update once rules_haskell can be updated.
    # sha256 = "e07e25e11068dcc570af1dfe30b01e893f89543671df194b7ebf39085ebffaf5",
    # version = "v0.44.1",
)

github_archive(
    name = "bazel_gazelle",
    repo = "bazelbuild/bazel-gazelle",
    sha256 = "4aa8e6c9cb98a9814c82289e4a87c661aa16c8b31bffa448163da8fd20a5bb93",
    version = "v0.35.0",
)

load("@io_bazel_rules_go//go:deps.bzl", "go_rules_dependencies")

go_rules_dependencies()

# Nixpkgs
# =========================================================

github_archive(
    name = "rules_haskell",
    repo = "tweag/rules_haskell",
    sha256 = "713d03014f08f20ad9d68fe458703f3f7bdbc8c94c21be22748af5728f5c7c4b",
    # TODO(https://github.com/tweag/rules_haskell/issues/2097): Upgrade once this bug is fixed.
    # version = "300963d75f4559398600f25b7f90afeba83d2b41",
    version = "d14584e7f227fee55d857694d6ba7dc7e74d8f3c",
)

load(
    "@rules_haskell//haskell:repositories.bzl",
    "rules_haskell_dependencies",
)

# Setup all Bazel dependencies required by rules_haskell.
rules_haskell_dependencies()

# Load nixpkgs_git_repository from rules_nixpkgs,
# which was already initialized by rules_haskell_dependencies above.
load(
    "@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl",
    "nixpkgs_cc_configure",
    "nixpkgs_git_repository",
    "nixpkgs_java_configure",
    "nixpkgs_nodejs_configure_platforms",
    "nixpkgs_package",
    "nixpkgs_python_configure",
)
load(
    "@io_tweag_rules_nixpkgs//toolchains/go:go.bzl",
    "nixpkgs_go_configure",
)

nixpkgs_git_repository(
    name = "nixpkgs",
    revision = "23.11",
    sha256 = "bc9a0a74e8d7fb0e11434dd3abaa0cb0572ccd3a65b5a192eea41832b286e8a0",
)

nixpkgs_cc_configure(
    attribute_path = "clang",
    nix_file_content = "(import <nixpkgs> {})",
    repository = "@nixpkgs",
)

nixpkgs_go_configure(
    repository = "@nixpkgs",
)

nixpkgs_python_configure(
    python3_attribute_path = "python3",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "diffutils",
    build_file = "//third_party:BUILD.diffutils",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "libllvm",
    attribute_path = "libllvm",
    build_file = "//third_party:BUILD.libllvm",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "autoconf",
    build_file = "//third_party:BUILD.autoconf",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "automake",
    build_file = "//third_party:BUILD.automake",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "libtool",
    build_file = "//third_party:BUILD.libtool",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "m4",
    build_file = "//third_party:BUILD.m4",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "cmake",
    build_file = "//third_party:BUILD.cmake",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "gnumake",
    build_file = "//third_party:BUILD.gnumake",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "perl",
    build_file = "//third_party:BUILD.perl",
    repository = "@nixpkgs",
)

# Java/Kotlin
# =========================================================

nixpkgs_java_configure(
    attribute_path = "jdk11.home",
    repository = "@nixpkgs",
    toolchain = True,
    toolchain_name = "nixpkgs_java",
    toolchain_version = "11",
)

github_archive(
    name = "rules_proto",
    repo = "bazelbuild/rules_proto",
    sha256 = "25f3acf1c73df6be2d920bbe42c2a0df2bea1c12daad9cc7e82fc0090b8ac922",
    version = "6.0.0-rc1",
)

github_archive(
    name = "rules_pkg",
    repo = "bazelbuild/rules_pkg",
    sha256 = "80d083438f579a9b1b76bb70e0f37a8d053858fa6683671fb1c8e2da0e61e8eb",
    version = "0.9.1",
)

http_archive(
    name = "remote_java_tools_linux",
    patch_cmds = [
        "chmod 755 java_tools/ijar/ijar",
        "{patchelf} --set-interpreter {ld_linux} --add-rpath {gcc_lib} java_tools/ijar/ijar".format(
            gcc_lib = "/nix/store/myw67gkgayf3s2mniij7zwd79lxy8v0k-gcc-12.3.0-lib/lib",
            ld_linux = "/nix/store/qn3ggz5sf3hkjs2c797xf7nan3amdxmp-glibc-2.38-27/lib64/ld-linux-x86-64.so.2",
            patchelf = "/nix/store/85jldj870vzcl72yz03labc93bwvqayx-patchelf-0.15.0/bin/patchelf",
        ),
        "chmod 555 java_tools/ijar/ijar",
        "chmod 755 java_tools/src/tools/singlejar/singlejar_local",
        "{patchelf} --set-interpreter {ld_linux} --add-rpath {gcc_lib} java_tools/src/tools/singlejar/singlejar_local".format(
            gcc_lib = "/nix/store/myw67gkgayf3s2mniij7zwd79lxy8v0k-gcc-12.3.0-lib/lib",
            ld_linux = "/nix/store/qn3ggz5sf3hkjs2c797xf7nan3amdxmp-glibc-2.38-27/lib64/ld-linux-x86-64.so.2",
            patchelf = "/nix/store/85jldj870vzcl72yz03labc93bwvqayx-patchelf-0.15.0/bin/patchelf",
        ),
        "chmod 555 java_tools/src/tools/singlejar/singlejar_local",
    ],
    sha256 = "b36ca871b27e09122f5e16fcfdbd25c30c43b528799a8f463e7bedb19b153ecc",
    urls = [
        "https://mirror.bazel.build/bazel_java_tools/releases/java/v13.2/java_tools_linux-v13.2.zip",
        "https://github.com/bazelbuild/java_tools/releases/download/java_v13.2/java_tools_linux-v13.2.zip",
    ],
)

github_archive(
    name = "rules_jvm_external",
    repo = "bazelbuild/rules_jvm_external",
    sha256 = "6cc8444b20307113a62b676846c29ff018402fd4c7097fcd6d0a0fd5f2e86429",
    version = "5.3",
)

github_archive(
    name = "io_bazel_stardoc",
    repo = "bazelbuild/stardoc",
    sha256 = "af5de1753e68de3c2afaf9b804074b60f808cc3f02d757adeea63eb649dfd886",
    version = "0.6.2",
)

github_archive(
    name = "rules_kotlin",
    repo = "bazelbuild/rules_kotlin",
    sha256 = "eec67a1438949f0bec00d6941223ba8009a5e232ef969e6110ccdcfb6d71349c",
    version = "v1.9.0",
)

load("@rules_kotlin//kotlin:repositories.bzl", "kotlin_repositories")

kotlin_repositories()

load("@rules_kotlin//kotlin:core.bzl", "kt_register_toolchains")

kt_register_toolchains()

# Haskell
# =========================================================

load(
    "@rules_haskell//haskell:nixpkgs.bzl",
    "haskell_register_ghc_nixpkgs",
)

# Fetch a GHC binary distribution from nixpkgs and register it as a toolchain.
# For more information:
# https://api.haskell.build/haskell/nixpkgs.html#haskell_register_ghc_nixpkgs
haskell_register_ghc_nixpkgs(
    attribute_path = "ghc",
    #fully_static_link = True,
    ghcopts = [
        "-Wall",
        "-Werror",
        "-XHaskell2010",
        "-fdiagnostics-color=always",
        # TODO(iphydf): Move to hs-cimple.
        "-Wno-redundant-constraints",
        "-optc=-Wno-unused-command-line-argument",
        "-optl=-Wl,--no-fatal-warnings",
    ],
    nix_file = "//:ghc.nix",
    repositories = {"nixpkgs": "@nixpkgs"},
    #static_runtime = True,
    version = "9.4.8",
)

[nixpkgs_package(
    name = "haskellPackages." + tool,
    build_file = "//third_party/haskell:BUILD." + tool,
    repository = "@nixpkgs",
) for tool in [
    "alex",
    "happy",
    "hspec-discover",
]]

# Go packages
# =========================================================

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies", "go_repository")

gazelle_dependencies()

go_repository(
    name = "com_github_things_go_go_socks5",
    commit = "2710f15218a8a0919385dfea9f9aa1434acbe4b3",
    importpath = "github.com/things-go/go-socks5",
)

go_repository(
    name = "com_github_gorilla_websocket",
    commit = "666c197fc9157896b57515c3a3326c3f8c8319fe",
    importpath = "github.com/gorilla/websocket",
)

go_repository(
    name = "com_github_streamrail_concurrent_map",
    commit = "8bf1e9bacbf65b10c81d0f4314cf2b1ebef728b5",
    importpath = "github.com/streamrail/concurrent-map",
)

go_repository(
    name = "com_github_petermattis_goid",
    commit = "1876fd5063bc764851a18bc0e050b9ab7adca065",
    importpath = "github.com/petermattis/goid",
)

go_repository(
    name = "com_github_sasha_s_go_deadlock",
    commit = "5afde13977e624ab3bd64e5801f75f9e8eb1f41b",
    importpath = "github.com/sasha-s/go-deadlock",
)

go_repository(
    name = "com_github_kardianos_osext",
    commit = "2bc1f35cddc0cc527b4bc3dce8578fc2a6c11384",
    importpath = "github.com/kardianos/osext",
)

# C/C++ dependencies
# =========================================================

nixpkgs_package(
    name = "alsa-lib",
    attribute_path = "alsa-lib",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "asound",
    attribute_path = "alsa-lib.dev",
    build_file = "//third_party:BUILD.asound",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "openssl.out",
    attribute_path = "openssl.out",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "openssl",
    attribute_path = "openssl.dev",
    build_file = "//third_party:BUILD.openssl",
    repository = "@nixpkgs",
)

http_archive(
    name = "ncurses",
    build_file = "@toktok//third_party:BUILD.ncurses",
    sha256 = "97fc51ac2b085d4cde31ef4d2c3122c21abc217e9090a43a30fc5ec21684e059",
    strip_prefix = "ncurses-6.3",
    urls = ["https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.3.tar.gz"],
)

http_archive(
    name = "ev",
    build_file = "@toktok//third_party:BUILD.ev",
    sha256 = "507eb7b8d1015fbec5b935f34ebed15bf346bed04a11ab82b8eee848c4205aea",
    strip_prefix = "libev-4.33",
    urls = ["http://dist.schmorp.de/libev/libev-4.33.tar.gz"],
)

github_archive(
    name = "boringssl",
    repo = "google/boringssl",
    sha256 = "9a1a9db5d0f6c1add527cccbd86a1bb75659afb4f9e1c26f44c97c3517db2400",
    version = "bf221ee64323dcebd2c64bd4c4a3269fc231d2bf",
)

http_archive(
    name = "bzip2",
    build_file = "@toktok//third_party:BUILD.bzip2",
    sha256 = "ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269",
    strip_prefix = "bzip2-1.0.8",
    urls = ["http://http.debian.net/debian/pool/main/b/bzip2/bzip2_1.0.8.orig.tar.gz"],
)

github_archive(
    name = "com_google_googletest",
    repo = "google/googletest",
    sha256 = "93b52882cff4e8fb344070106facee0df5e61be91b1948a69c8581b3bcbe0c61",
    version = "b3a9ba2b8e975550799838332803d468797ae2e1",
)

github_archive(
    name = "benchmark",
    repo = "google/benchmark",
    sha256 = "abfc22e33e3594d0edf8eaddaf4d84a2ffc491ad74b6a7edc6e7a608f690e691",
    version = "v1.8.3",
)

new_github_archive(
    name = "curl",
    repo = "curl/curl",
    sha256 = "a5850615a9f4a1fdf55dc6023cf9b10c8b320eb6cc17ed77dc7edb7603e06684",
    version = "curl-8_2_1",
)

new_github_archive(
    name = "ffnvcodec",
    repo = "FFmpeg/nv-codec-headers",
    sha256 = "f1fd5adb2ed6815e7debff30cb44b21188dc65da42b7a67537f28256e8e71c29",
    version = "250292dd20af60edc6e0d07f1d6e489a2f8e1c44",
)

http_archive(
    name = "ffmpeg",
    build_file = "@toktok//third_party:BUILD.ffmpeg",
    sha256 = "eb7da3de7dd3ce48a9946ab447a7346bd11a3a85e6efb8f2c2ce637e7f547611",
    strip_prefix = "ffmpeg-6.1",
    urls = ["https://ffmpeg.org/releases/ffmpeg-6.1.tar.bz2"],
)

http_archive(
    name = "gettext",
    build_file = "@toktok//third_party:BUILD.gettext",
    sha256 = "839a260b2314ba66274dae7d245ec19fce190a3aa67869bf31354cb558df42c7",
    strip_prefix = "gettext-0.22.3",
    urls = ["https://ftp.gnu.org/pub/gnu/gettext/gettext-0.22.3.tar.gz"],
)

nixpkgs_package(
    name = "gl.out",
    attribute_path = "libGL.out",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "gl",
    attribute_path = "libGL.dev",
    build_file = "@toktok//third_party:BUILD.gl",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "glvnd.out",
    attribute_path = "libGL.out",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "glvnd",
    attribute_path = "libglvnd.dev",
    build_file = "@toktok//third_party:BUILD.glvnd",
    repository = "@nixpkgs",
)

http_archive(
    name = "json",
    build_file = "@toktok//third_party:BUILD.json",
    sha256 = "87b5884741427220d3a33df1363ae0e8b898099fbc59f1c451113f6732891014",
    strip_prefix = "include",
    urls = ["https://github.com/nlohmann/json/releases/download/v3.7.3/include.zip"],
)

http_archive(
    name = "libcap",
    build_file = "@toktok//third_party:BUILD.libcap",
    sha256 = "db7de848064e656a0bb528dae6d53ff20c82e849d509cecd015a04d2fec8369d",
    strip_prefix = "libcap-2.33",
    urls = ["https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.33.tar.gz"],
)

new_github_archive(
    name = "libconfig",
    repo = "hyperrealm/libconfig",
    sha256 = "a3ae202153fafb40558c26831429ce39845b2395ad8d30269a50e309a7585a8c",
    version = "v1.7.2",
)

new_github_archive(
    name = "libexif",
    repo = "libexif/libexif",
    sha256 = "7f283fee7c949944eb3e0066cd5763355dc5591ad15ea96910cb2f24adca43f3",
    version = "154189b77491191e00e1204083ab51c4ad5a60ff",
)

http_archive(
    name = "libidn2",
    build_file = "@toktok//third_party:BUILD.libidn2",
    sha256 = "e1cb1db3d2e249a6a3eb6f0946777c2e892d5c5dc7bd91c74394fc3a01cab8b5",
    strip_prefix = "libidn2-2.3.0",
    urls = ["https://ftp.gnu.org/gnu/libidn/libidn2-2.3.0.tar.gz"],
)

new_github_archive(
    name = "libqrencode",
    repo = "fukuchi/libqrencode",
    sha256 = "0b9af8ce90939259465e2b0f100a60433eaa4242269738c71d46f311cf557401",
    version = "715e29fd4cd71b6e452ae0f4e36d917b43122ce8",
)

new_github_archive(
    name = "libsodium",
    patches = ["@toktok//third_party/patches:libsodium.patch"],
    repo = "jedisct1/libsodium",
    sha256 = "310cb8149ba12342d0cd64ae81d0c7ed60d608732685e3c6b8c359bba572cfd3",
    version = "1.0.19",
)

new_github_archive(
    name = "libvpx",
    repo = "webmproject/libvpx",
    sha256 = "24ab597b3598503e9af89262bcacda2185e7865ddcb2cf004355833bc33fcf1b",
    version = "v1.13.1",
)

new_github_archive(
    name = "libzmq",
    repo = "zeromq/libzmq",
    sha256 = "49b9d6cd12275d94a27724fcda646554f13af27857e3fe778b72cb245c74976e",
    version = "v4.3.5",
)

new_github_archive(
    name = "openal",
    repo = "kcat/openal-soft",
    #sha256 = "dd4e36a61ac4726574a3d6e96492f2e136e12ccfc9f9b5e6f22a45713613c98b",
    #version = "1.23.1",
    sha256 = "4acd4cdd3295658c8cfdf53b67782f6812ab9499913ed2dc9acc03c6cf7329c5",
    version = "openal-soft-1.20.1",
)

new_github_archive(
    name = "opus",
    repo = "xiph/opus",
    sha256 = "43cbfbe91f12995a6066fe032762fe25ffea5f713cc7fb17f579aa4dcbf112bb",
    version = "v1.4",
)

http_archive(
    name = "pthread_w32",
    build_file = "@toktok//third_party:BUILD.pthread_w32",
    sha256 = "e6aca7aea8de33d9c8580bcb3a0ea3ec0a7ace4ba3f4e263ac7c7b66bc95fb4d",
    strip_prefix = "pthreads-w32-2-9-1-release",
    urls = ["https://sourceware.org/pub/pthreads-win32/pthreads-w32-2-9-1-release.tar.gz"],
)

new_local_repository(
    name = "pthread",
    build_file = "third_party/BUILD.pthread",
    path = "third_party",
)

new_local_repository(
    name = "psocket",
    build_file = "third_party/BUILD.psocket",
    path = "third_party",
)

http_archive(
    name = "libxz",
    build_file = "@toktok//third_party:BUILD.libxz",
    sha256 = "135c90b934aee8fbc0d467de87a05cb70d627da36abe518c357a873709e5b7d6",
    strip_prefix = "xz-5.4.5",
    urls = ["https://netix.dl.sourceforge.net/project/lzmautils/xz-5.4.5.tar.gz"],
)

http_archive(
    name = "sdl2",
    build_file = "@toktok//third_party:BUILD.sdl2",
    sha256 = "349268f695c02efbc9b9148a70b85e58cefbbf704abd3e91be654db7f1e2c863",
    strip_prefix = "SDL2-2.0.12",
    urls = ["https://www.libsdl.org/release/SDL2-2.0.12.tar.gz"],
    # TODO(iphydf): Update.
    # sha256 = "332cb37d0be20cb9541739c61f79bae5a477427d79ae85e352089afdaf6666e4",
    # strip_prefix = "SDL2-2.28.5",
    # urls = ["https://www.libsdl.org/release/SDL2-2.28.5.tar.gz"],
)

new_github_archive(
    name = "sqlcipher",
    repo = "sqlcipher/sqlcipher",
    sha256 = "a35364ce8ecbcf4f3ef21d5e4139cea0f6bec3aaaeb749bae3c2988fcc2b1b6a",
    version = "v4.5.5",
)

new_github_archive(
    name = "tcl",
    repo = "tcltk/tcl",
    sha256 = "a2a8789d6fbe8dcbb17ed5c19d71539045f818cf657128bcef8740f6a40436f7",
    version = "149b0e616bdf5f74071665caf6bf4f59d80ea0fc",
)

nixpkgs_package(
    name = "x11.out",
    attribute_path = "xorg.libX11.out",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "x11",
    attribute_path = "xorg.libX11.dev",
    build_file = "@toktok//third_party:BUILD.x11",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "xcb.out",
    attribute_path = "xorg.libxcb.out",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "xcb",
    attribute_path = "xorg.libxcb.dev",
    build_file = "@toktok//third_party:BUILD.xcb",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "xext.out",
    attribute_path = "xorg.libXext.out",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "xext",
    attribute_path = "xorg.libXext.dev",
    build_file = "@toktok//third_party:BUILD.xext",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "xxf86vm.out",
    attribute_path = "xorg.libXxf86vm.out",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "xxf86vm",
    attribute_path = "xorg.libXxf86vm.dev",
    build_file = "@toktok//third_party:BUILD.xxf86vm",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "xproto",
    attribute_path = "xorg.xorgproto.out",
    build_file = "@toktok//third_party:BUILD.xproto",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "xss",
    attribute_path = "xorg.libXScrnSaver",
    build_file = "@toktok//third_party:BUILD.xss",
    repository = "@nixpkgs",
)

new_github_archive(
    name = "yasm",
    repo = "yasm/yasm",
    sha256 = "3d0938894e065b10a1a14b6e29e67208125dab18f6061bc6b73713cd75dd265d",
    version = "2cd3bb50e256f5ed5f611ac611d25fe673f2cec3",
)

# Apple frameworks
# =========================================================

github_archive(
    name = "build_bazel_rules_apple",
    repo = "bazelbuild/rules_apple",
    sha256 = "b6a45e2fc047e4da9f474259dc9ab5cd19391db0e0fbfe9acd0fc1ee361266ff",
    version = "07f5f2dd14f56e54eaca176630450c2abcc52eb9",
)

github_archive(
    name = "build_bazel_rules_swift",
    repo = "bazelbuild/rules_swift",
    sha256 = "cf74bbd9dc803b9b551de03bdb43feb75666cdd74cd70513c07b950a12a829c8",
    version = "7b8558cab8e402eb21e2fc655989bae378171486",
)

github_archive(
    name = "build_bazel_apple_support",
    repo = "bazelbuild/apple_support",
    sha256 = "0c255725a9be81cde845fd3b9a936c4d5f46b0e1891c02082259f387e0db9e3c",
    version = "2659bae1f561e34b89fcc230df26aaf6dada2646",
)

load("@build_bazel_apple_support//lib:repositories.bzl", "apple_support_dependencies")
load("@build_bazel_rules_apple//apple:repositories.bzl", "apple_rules_dependencies")
load("@build_bazel_rules_swift//swift:repositories.bzl", "swift_rules_dependencies")

apple_rules_dependencies()

swift_rules_dependencies()

apple_support_dependencies()

# Qt5
# =========================================================

QT_LIBS = [
    "base",
    "multimedia",
    "svg",
]

nixpkgs_package(
    name = "qt5.qtbase.bin",
    build_file = "//third_party/qt:BUILD.qtbase.bin",
    repository = "@nixpkgs",
)

[nixpkgs_package(
    name = "qt5.qt%s.out" % lib,
    build_file = "//third_party/qt:BUILD.qt%s.out" % lib,
    repository = "@nixpkgs",
) for lib in QT_LIBS]

[nixpkgs_package(
    name = "qt5.qt%s.dev" % lib,
    build_file = "//third_party/qt:BUILD.qt%s.dev" % lib,
    repository = "@nixpkgs",
) for lib in QT_LIBS]

nixpkgs_package(
    name = "qt",
    attribute_path = "qt5.qttools.dev",
    build_file = "//third_party:BUILD.qt",
    repository = "@nixpkgs",
)

# Python
# =========================================================

load("//tools/workspace:python.bzl", "python_repository")

python_repository(
    name = "python3",
)

github_archive(
    name = "cython",
    repo = "cython/cython",
    sha256 = "6fac075cab5fed1e20a284b1caba3ac09b31867daef480f0149eec1a1c981c61",
    version = "3.0.7",
)

new_github_archive(
    name = "mypy",
    repo = "python/mypy",
    sha256 = "57788ce99c6e7e6f41ac9e5f514a08ee4b2121847e3dcaa16a1aec941d025d27",
    version = "v1.6.0",
)

new_github_archive(
    name = "mypy_extensions",
    repo = "python/mypy_extensions",
    sha256 = "73a374063a9e5685d9e424462bf8ba1013c79169733eefbd20010ee5d6157a73",
    version = "1.0.0",
)

new_github_archive(
    name = "typing_extensions",
    repo = "python/typing_extensions",
    sha256 = "23d3202b2a220832bf81b8f0184d4d91b8d21abde2700fdcdca6ff9f02eb2619",
    strip_prefix = "/src",
    version = "4.9.0",
)

# Node.js
# =========================================================

github_archive(
    name = "build_bazel_rules_nodejs",
    repo = "bazelbuild/rules_nodejs",
    sha256 = "adabe513387911365169a1403ca04f72ad5c4c079489fd5896b15ddb526ce3bd",
    version = "5.8.0",
)

load("@build_bazel_rules_nodejs//:repositories.bzl", "build_bazel_rules_nodejs_dependencies")

build_bazel_rules_nodejs_dependencies()

nixpkgs_nodejs_configure_platforms(
    repository = "@nixpkgs",
)

load("@build_bazel_rules_nodejs//:index.bzl", "npm_install")

npm_install(
    name = "npm",
    exports_directories_only = True,
    node_repository = "nixpkgs_nodejs",
    package_json = "//js-toxcore-c:package.json",
    package_lock_json = "//js-toxcore-c:package-lock.json",
)

## Node.js
## =========================================================
#
##github_archive(
##    name = "rules_codeowners",
##    repo = "zegl/rules_codeowners",
##    #sha256 = "06910242c6d47c5719efd5789cf34dac393034dc0fe4c73f1ed3aac739ffabdc",
##    version = "bdc2f987cd0e15ebfa9b76689a4c9a472730a6f0",
##)
##
##github_archive(
##    name = "build_bazel_rules_nodejs",
##    repo = "bazelbuild/rules_nodejs",
##    sha256 = "171bdbd8386576ed2f6a3f8aff87eeb048f963981870a3a8432be7d12cf5b2cc",
##    version = "1.3.0",
##)
##
##load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")
##
##yarn_install(
##    name = "npm",
##    package_json = "//js-toxcore-c:package.json",
##    yarn_lock = "//js-toxcore-c:yarn.lock",
##)
#
##load("@npm//:install_bazel_dependencies.bzl", "install_bazel_dependencies")
##install_bazel_dependencies()
#
##load("@org_pubref_rules_node//node:rules.bzl", "node_repositories", "yarn_modules")
##
##node_repositories()
##
##yarn_modules(
##    name = "yarn_modules",
##    install_tools = [
##        "sh",
##        "dirname",
##    ],
##    deps = {
##        "ansi-to-html": "0.6.4",
##        "async": "2.6.0",
##        "buffertools": "2.1.6",
##        "ffi": "2.2.0",
##        "firebase": "3.9.0",
##        "firepad": "1.4.0",
##        "grunt": "1.0.1",
##        "grunt-jsdoc": "2.2.1",
##        "grunt-shell": "2.1.0",
##        "ink-docstrap": "1.3.2",
##        "jsdoc": "3.5.5",
##        "mktemp": "0.4.0",
##        "mocha": "3.5.3",
##        "ref": "1.3.5",
##        "ref-array": "1.2.0",
##        "ref-struct": "1.1.0",
##        "should": "13.2.1",
##        "underscore": "1.8.3",
##    },
##)
##
##yarn_modules(
##    name = "mocha_modules",
##    deps = {"mocha": "3.5.3"},
##)
#
## Compilation database
## =========================================================
#
## Tool used for creating a compilation database.
#github_archive(
#    name = "io_kythe",
#    repo = "kythe/kythe",
#    sha256 = "6e4358e780768cae8a98ddf7059e588228bfd3319b24a4ab03cedc84231b14b4",
#    version = "v0.0.63",
#)
#
#http_archive(
#    name = "com_github_tencent_rapidjson",
#    build_file = "@io_kythe//third_party:rapidjson.BUILD",
#    sha256 = "e6fc99c7df7f29995838a764dd68df87b71db360f7727ace467b21b82c85efda",
#    strip_prefix = "rapidjson-8f4c021fa2f1e001d2376095928fc0532adf2ae6",
#    url = "https://github.com/Tencent/rapidjson/archive/8f4c021fa2f1e001d2376095928fc0532adf2ae6.zip",
#)
#
#new_github_archive(
#    name = "com_github_google_glog",
#    build_file_content = "\n".join([
#        "load(\"//:bazel/glog.bzl\", \"glog_library\")",
#        "glog_library(with_gflags=0)",
#    ]),
#    repo = "google/glog",
#    sha256 = "feca3c7e29a693cab7887409756d89d342d4a992d54d7c5599bebeae8f7b50be",
#    version = "3ba8976592274bc1f907c402ce22558011d6fc5e",
#)
#
#load("@io_kythe//:setup.bzl", "kythe_rule_repositories")
#
#kythe_rule_repositories()

# Tox Extension modules
# =========================================================

new_github_archive(
    name = "toxext",
    repo = "toxext/toxext",
    sha256 = "55c2aabc7ba87a435bb5c68d7ae0513aa3ada11c18a55a3fca2e42231d351a08",
    version = "v0.0.3",
)

new_github_archive(
    name = "tox_extension_messages",
    repo = "toxext/tox_extension_messages",
    sha256 = "f72da1fff2f6048c60fd8993fce2fc64aae58aa689744ae5ee5fc4381209b41e",
    version = "v0.0.3",
)
