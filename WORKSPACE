workspace(name = "toktok")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//third_party:nixpkgs.bzl", "GCC_LIB", "GHC_VERSION", "LD_LINUX", "NIXOS_SHA256", "NIXOS_VERSION", "PATCHELF")
load("//tools/workspace:github.bzl", "github_archive", "new_github_archive")

# https://github.com/bazelbuild/bazel-skylib
github_archive(
    name = "bazel_skylib",
    #integrity = "sha256-s6wuTWaJ/u/ZzA7hIycriiOmdRJg8+iK38fKheZjybs=",
    repo = "bazelbuild/bazel-skylib",
    sha256 = "385c4e9cef8538388e7e457c8cf282ecd2415e70970ad99f885a934ca9071220",
    # boringssl is not compatible with 1.7.0+.
    version = "1.6.1",
)

# Third-party Bazel
# =========================================================

# https://github.com/uber/hermetic_cc_toolchain
github_archive(
    name = "hermetic_cc_toolchain",
    integrity = "sha256-MfL5fnXBtFa25YrsZkgAxjVP+4v5viC47EyZwyjDLsY=",
    repo = "uber/hermetic_cc_toolchain",
    version = "8e68b7221ca72c10268338eb1734530438e5ccb7",
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

# https://github.com/aherrmann/rules_zig
github_archive(
    name = "rules_zig",
    integrity = "sha256-93KFvVQzhf5ptnFjDEc56wtntkTcD2kYTs3XEj3w4uA=",
    repo = "aherrmann/rules_zig",
    version = "v0.6.0",
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

# Python
# =========================================================

load("//tools/workspace:python.bzl", "python_repository")

# https://github.com/bazelbuild/rules_python
github_archive(
    name = "rules_python",
    integrity = "sha256-QztU/bqTx7ImS00d9FjdaV9VF4l+9Ihu7r2Ns9/53m4=",
    repo = "bazelbuild/rules_python",
    version = "0.40.0",
)

load("@rules_python//python:repositories.bzl", "py_repositories")

py_repositories()

python_repository(
    name = "python3",
)

# https://github.com/cython/cython
github_archive(
    name = "cython",
    repo = "cython/cython",
    sha256 = "74a16730c19c76177634512a0aa3b81d92c4cce41720a95f9478e6d6ce828724",
    version = "3.0.11-1",
)

# https://github.com/python/mypy
new_github_archive(
    name = "mypy",
    repo = "python/mypy",
    sha256 = "44374d34dbd6f5bbf9f81fc86cc4ebd390a0d57b1afe461dbbc8bab205192318",
    version = "v1.13.0",
)

# https://github.com/python/mypy_extensions
new_github_archive(
    name = "mypy_extensions",
    repo = "python/mypy_extensions",
    sha256 = "73a374063a9e5685d9e424462bf8ba1013c79169733eefbd20010ee5d6157a73",
    version = "1.0.0",
)

# https://github.com/python/typing_extensions
new_github_archive(
    name = "typing_extensions",
    repo = "python/typing_extensions",
    sha256 = "d87daad3047de97e0fa0ea5fa23d2ba5748d0f93b64cc0d775e7d1df0d4090ed",
    strip_prefix = "/src",
    version = "4.12.2",
)

# Fuzzing
# =========================================================

# https://github.com/bazelbuild/rules_fuzzing
github_archive(
    name = "rules_fuzzing",
    repo = "bazelbuild/rules_fuzzing",
    sha256 = "e6bc219bfac9e1f83b327dd090f728a9f973ee99b9b5d8e5a184a2732ef08623",
    version = "v0.5.2",
)

load("@rules_fuzzing//fuzzing:repositories.bzl", "rules_fuzzing_dependencies")

rules_fuzzing_dependencies()

load("@rules_fuzzing//fuzzing:init.bzl", "rules_fuzzing_init")

rules_fuzzing_init()

load("@fuzzing_py_deps//:requirements.bzl", "install_deps")

install_deps()

# Go
# =========================================================

# https://github.com/bazelbuild/rules_go
github_archive(
    name = "io_bazel_rules_go",
    repo = "bazelbuild/rules_go",
    sha256 = "1f9702aef8d2b106a216f6a7729a7208bf1c110dec3dbff07d81e553115ff32b",
    version = "v0.50.1",
)

# https://github.com/bazelbuild/bazel-gazelle
github_archive(
    name = "bazel_gazelle",
    integrity = "sha256-Hp3LG4q5mRKH6wjFbPZsNB3JHbAv2yGQrLiNVvccSYQ=",
    repo = "bazelbuild/bazel-gazelle",
    version = "v0.40.0",
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.23.4")

# Nixpkgs
# =========================================================

load("//tools/workspace:rules_nixpkgs.bzl", "rules_nixpkgs_dependencies")

rules_nixpkgs_dependencies()

# https://github.com/tweag/rules_haskell
github_archive(
    name = "rules_haskell",
    integrity = "sha256-SgLeJQFI4JmSeN8SNnwRAIpB2MXfN8bAA5x0uw6VkRo=",
    repo = "tweag/rules_haskell",
    version = "4169f8acc725669d50c801d216480b8e192841cb",
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

nixpkgs_git_repository(
    name = "nixpkgs",
    revision = NIXOS_VERSION,
    sha256 = NIXOS_SHA256,
)

nixpkgs_cc_configure(
    attribute_path = "clang",
    nix_file_content = "(import <nixpkgs> {})",
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
    attribute_path = "jdk21_headless.home",
    repository = "@nixpkgs",
    toolchain = True,
    toolchain_name = "nixpkgs_java",
    toolchain_version = "21",
)

# https://github.com/bazelbuild/rules_proto
github_archive(
    name = "rules_proto",
    integrity = "sha256-izdEYHo671xV0XkJ8HPV7UCZByP+/mMbIuqzXidriT0=",
    repo = "bazelbuild/rules_proto",
    version = "6.0.2",
)

http_archive(
    name = "remote_java_tools_linux",
    patch_cmds = [
        "chmod 755 java_tools/ijar/ijar",
        "{patchelf} --set-interpreter {ld_linux} --add-rpath {gcc_lib} java_tools/ijar/ijar".format(
            gcc_lib = GCC_LIB,
            ld_linux = LD_LINUX,
            patchelf = PATCHELF,
        ),
        "chmod 555 java_tools/ijar/ijar",
        "chmod 755 java_tools/src/tools/singlejar/singlejar_local",
        "{patchelf} --set-interpreter {ld_linux} --add-rpath {gcc_lib} java_tools/src/tools/singlejar/singlejar_local".format(
            gcc_lib = GCC_LIB,
            ld_linux = LD_LINUX,
            patchelf = PATCHELF,
        ),
        "chmod 555 java_tools/src/tools/singlejar/singlejar_local",
    ],
    sha256 = "7a3d7b1cd080efdf49ab2a3818177799416734acf2bd23040aa9037141287548",
    urls = [
        "https://mirror.bazel.build/bazel_java_tools/releases/java/v13.9/java_tools_linux-v13.9.zip",
        "https://github.com/bazelbuild/java_tools/releases/download/java_v13.9/java_tools_linux-v13.9.zip",
    ],
)

# https://github.com/bazelbuild/rules_jvm_external
github_archive(
    name = "rules_jvm_external",
    integrity = "sha256-xbJ5KO648HYfCAVUBYdmDw7MaUbpwEvw1MieL30zKys=",
    repo = "bazelbuild/rules_jvm_external",
    version = "6.5",
)

load("@rules_jvm_external//:repositories.bzl", "rules_jvm_external_deps")

rules_jvm_external_deps()

load("@rules_jvm_external//:setup.bzl", "rules_jvm_external_setup")

rules_jvm_external_setup()

load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    artifacts = [
        "org.jetbrains.kotlin:kotlin-test-junit:1.9.22",
        "org.jetbrains.kotlinx:kotlinx-coroutines-core:1.8.0",
    ],
    repositories = [
        "https://repo1.maven.org/maven2",
    ],
)

# https://github.com/bazelbuild/rules_kotlin
github_archive(
    name = "rules_kotlin",
    is_release = True,
    repo = "bazelbuild/rules_kotlin",
    sha256 = "3b772976fec7bdcda1d84b9d39b176589424c047eb2175bed09aac630e50af43",
    version = "v1.9.6",
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
        # TODO(iphydf): Move to hs-schema.
        "-Wno-unused-imports",
        "-optc=-Wno-unused-command-line-argument",
        "-optl=-Wl,--no-fatal-warnings",
    ],
    nix_file = "//:ghc.nix",
    repositories = {"nixpkgs": "@nixpkgs"},
    #static_runtime = True,
    version = GHC_VERSION,
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

# https://github.com/things-go/go-socks5
go_repository(
    name = "com_github_things_go_go_socks5",
    commit = "ebe069a7b637b8a57b5586c31dca909bf35521e7",
    importpath = "github.com/things-go/go-socks5",
)

# https://github.com/gorilla/websocket
go_repository(
    name = "com_github_gorilla_websocket",
    commit = "5e002381133d322c5f1305d171f3bdd07decf229",
    importpath = "github.com/gorilla/websocket",
)

# https://github.com/streamrail/concurrent-map
go_repository(
    name = "com_github_streamrail_concurrent_map",
    commit = "8bf1e9bacbf65b10c81d0f4314cf2b1ebef728b5",
    importpath = "github.com/streamrail/concurrent-map",
)

# https://github.com/petermattis/goid
go_repository(
    name = "com_github_petermattis_goid",
    commit = "66cb2e6d7274e9d57368662b1e3dd92eeb21492b",
    importpath = "github.com/petermattis/goid",
)

# https://github.com/sasha-s/go-deadlock
go_repository(
    name = "com_github_sasha_s_go_deadlock",
    commit = "464d34347a399b840a4f963cc96dfc993ccf8c62",
    importpath = "github.com/sasha-s/go-deadlock",
)

# https://github.com/kardianos/osext
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

# https://ftp.gnu.org/pub/gnu/ncurses
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

# https://github.com/google/boringssl
github_archive(
    name = "boringssl",
    integrity = "sha256-aE4zQXpj8PfJFqCtg1a+qTcSpvQQpeR60Q4pqEo9Lgc=",
    repo = "google/boringssl",
    version = "391bd56eaaa8b0a00cdb0f9a4ed25cc0f11c9791",
)

http_archive(
    name = "bzip2",
    build_file = "@toktok//third_party:BUILD.bzip2",
    sha256 = "ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269",
    strip_prefix = "bzip2-1.0.8",
    urls = ["https://www.sourceware.org/pub/bzip2/bzip2-latest.tar.gz"],
)

# https://github.com/google/googletest
github_archive(
    name = "com_google_googletest",
    repo = "google/googletest",
    sha256 = "f179ec217f9b3b3f3c6e8b02d3e7eda997b49e4ce26d6b235c9053bec9c0bf9f",
    version = "v1.15.2",
)

# https://github.com/google/benchmark
github_archive(
    name = "benchmark",
    repo = "google/benchmark",
    sha256 = "8a63c9c6adf9e7ce8d0d81f251c47de83efb5e077e147d109fa2045daac8368b",
    version = "v1.9.1",
)

# https://github.com/curl/curl
new_github_archive(
    name = "curl",
    repo = "curl/curl",
    sha256 = "5216ed22ac04954d95d39bd5d796b31ca55b482d998a830e7493452a4c6ce7e9",
    version = "curl-8_10_1",
)

# https://github.com/FFmpeg/nv-codec-headers
new_github_archive(
    name = "ffnvcodec",
    repo = "FFmpeg/nv-codec-headers",
    sha256 = "f9cdd2dd0eff4c86769d9c427fe743d0038c166f4831f008d37500deec65128e",
    version = "9934f17316b66ce6de12f3b82203a298bc9351d8",
)

# https://ffmpeg.org/releases
http_archive(
    name = "ffmpeg",
    build_file = "@toktok//third_party:BUILD.ffmpeg",
    sha256 = "fd59e6160476095082e94150ada5a6032d7dcc282fe38ce682a00c18e7820528",
    strip_prefix = "ffmpeg-7.1",
    urls = ["https://ffmpeg.org/releases/ffmpeg-7.1.tar.bz2"],
)

# https://ftp.gnu.org/pub/gnu/gettext
http_archive(
    name = "gettext",
    build_file = "@toktok//third_party:BUILD.gettext",
    sha256 = "ec1705b1e969b83a9f073144ec806151db88127f5e40fe5a94cb6c8fa48996a0",
    strip_prefix = "gettext-0.22.5",
    urls = ["https://ftp.gnu.org/pub/gnu/gettext/gettext-0.22.5.tar.gz"],
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
    attribute_path = "libglvnd.out",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "glvnd",
    attribute_path = "libglvnd.dev",
    build_file = "@toktok//third_party:BUILD.glvnd",
    repository = "@nixpkgs",
)

# https://github.com/nlohmann/json
http_archive(
    name = "json",
    build_file = "@toktok//third_party:BUILD.json",
    sha256 = "a22461d13119ac5c78f205d3df1db13403e58ce1bb1794edc9313677313f4a9d",
    strip_prefix = "include",
    urls = ["https://github.com/nlohmann/json/releases/download/v3.11.3/include.zip"],
)

http_archive(
    name = "libcap",
    build_file = "@toktok//third_party:BUILD.libcap",
    sha256 = "db7de848064e656a0bb528dae6d53ff20c82e849d509cecd015a04d2fec8369d",
    strip_prefix = "libcap-2.33",
    urls = ["https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.33.tar.gz"],
)

# https://github.com/hyperrealm/libconfig
new_github_archive(
    name = "libconfig",
    integrity = "sha256-hTSG4pEWJa0E/mHY7m5tZ5TUu5ID5qMQC9as6Loqrk0=",
    repo = "hyperrealm/libconfig",
    version = "e4c5d2cadb72c988ba0b7265610b448cba521f79",
)

# https://github.com/libexif/libexif
new_github_archive(
    name = "libexif",
    repo = "libexif/libexif",
    sha256 = "8e418041aba29a956eaf4ae1e0aa46bbc1a73d66916f6c3bf596067f13f942a5",
    version = "00ee559ac8293c6ab9b0b4d26d3650ec89d2b1fc",
)

http_archive(
    name = "libidn2",
    build_file = "@toktok//third_party:BUILD.libidn2",
    sha256 = "e1cb1db3d2e249a6a3eb6f0946777c2e892d5c5dc7bd91c74394fc3a01cab8b5",
    strip_prefix = "libidn2-2.3.0",
    urls = ["https://ftp.gnu.org/gnu/libidn/libidn2-2.3.0.tar.gz"],
)

# https://github.com/fukuchi/libqrencode
new_github_archive(
    name = "libqrencode",
    repo = "fukuchi/libqrencode",
    sha256 = "0b9af8ce90939259465e2b0f100a60433eaa4242269738c71d46f311cf557401",
    version = "715e29fd4cd71b6e452ae0f4e36d917b43122ce8",
)

# https://github.com/jedisct1/libsodium
new_github_archive(
    name = "libsodium",
    patches = ["@toktok//third_party/patches:libsodium.patch"],
    repo = "jedisct1/libsodium",
    sha256 = "417f46f586d33bf7429352faad99ba35b98fea9bf0bc678b16ddf48bc2af41e7",
    version = "1.0.20-RELEASE",
)

# https://github.com/webmproject/libvpx
new_github_archive(
    name = "libvpx",
    repo = "webmproject/libvpx",
    sha256 = "9c4bd72226fe644f7283613cd624c80dbef1da413092a496393d16395206c291",
    version = "v1.15.0",
)

# https://github.com/zeromq/libzmq
new_github_archive(
    name = "libzmq",
    repo = "zeromq/libzmq",
    sha256 = "49b9d6cd12275d94a27724fcda646554f13af27857e3fe778b72cb245c74976e",
    version = "v4.3.5",
)

# https://github.com/kcat/openal-soft
new_github_archive(
    name = "openal",
    repo = "kcat/openal-soft",
    #sha256 = "dd4e36a61ac4726574a3d6e96492f2e136e12ccfc9f9b5e6f22a45713613c98b",
    #version = "1.23.1",
    sha256 = "4acd4cdd3295658c8cfdf53b67782f6812ab9499913ed2dc9acc03c6cf7329c5",
    version = "openal-soft-1.20.1",
)

# https://github.com/xiph/opus
new_github_archive(
    name = "opus",
    repo = "xiph/opus",
    sha256 = "c26f6200778c844cf5211f0d2dbaafadce3f20e9e8efe7495e01aaa9987c5b13",
    version = "v1.5.2",
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
    build_file = "//third_party:BUILD.pthread",
    path = "third_party/pthread",
)

new_local_repository(
    name = "psocket",
    build_file = "//third_party:BUILD.psocket",
    path = "third_party",
)

# https://github.com/tukaani-project/xz/releases
http_archive(
    name = "libxz",
    build_file = "@toktok//third_party:BUILD.libxz",
    sha256 = "b1d45295d3f71f25a4c9101bd7c8d16cb56348bbef3bbc738da0351e17c73317",
    strip_prefix = "xz-5.6.3",
    urls = ["https://github.com/tukaani-project/xz/releases/download/v5.6.3/xz-5.6.3.tar.gz"],
)

http_archive(
    name = "sdl2",
    build_file = "@toktok//third_party:BUILD.sdl2",
    sha256 = "349268f695c02efbc9b9148a70b85e58cefbbf704abd3e91be654db7f1e2c863",
    strip_prefix = "SDL2-2.0.12",
    urls = ["https://github.com/libsdl-org/SDL/releases/download/release-2.0.12/SDL2-2.0.12.tar.gz"],
    # TODO(iphydf): Update.
    # sha256 = "332cb37d0be20cb9541739c61f79bae5a477427d79ae85e352089afdaf6666e4",
    # strip_prefix = "SDL2-2.28.5",
    # urls = ["https://www.libsdl.org/release/SDL2-2.28.5.tar.gz"],
)

# https://github.com/sqlcipher/sqlcipher
new_github_archive(
    name = "sqlcipher",
    repo = "sqlcipher/sqlcipher",
    sha256 = "93a7475183d47e2d33f85aefa7518e8730796f103612d36ae191ae56209104e0",
    version = "v4.6.1",
)

# https://github.com/tcltk/tcl
new_github_archive(
    name = "tcl",
    repo = "tcltk/tcl",
    sha256 = "cb79bf805a7ee1227106167ab398017e5a4199eeb1eb3da24d5e70f8a3614614",
    version = "a18a9d248b4794c7a0c70698c2575bc78d3c1ae4",
)

nixpkgs_package(
    name = "libnotify.out",
    attribute_path = "libnotify",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "libnotify",
    attribute_path = "libnotify.dev",
    build_file = "@toktok//third_party:BUILD.libnotify",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "gdk-pixbuf.out",
    attribute_path = "gdk-pixbuf",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "gdk-pixbuf",
    attribute_path = "gdk-pixbuf.dev",
    build_file = "@toktok//third_party:BUILD.gdk-pixbuf",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "glib.out",
    attribute_path = "glib.out",
    build_file = "@toktok//third_party:BUILD.glib.out",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "glib",
    attribute_path = "glib.dev",
    build_file = "@toktok//third_party:BUILD.glib",
    repository = "@nixpkgs",
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

# https://github.com/yasm/yasm
new_github_archive(
    name = "yasm",
    repo = "yasm/yasm",
    sha256 = "29c53164101569643eb3ea73c1badd4e489690132042bb751edcd47ece8c0ea4",
    version = "121ab150b3577b666c79a79f4a511798d7ad2432",
)

# Apple frameworks
# =========================================================

# https://github.com/bazelbuild/rules_apple
github_archive(
    name = "build_bazel_rules_apple",
    integrity = "sha256-GhXdvG95AvfUVbLvJKutxf9C3FLcR2m6q7t7XZyEHcc=",
    repo = "bazelbuild/rules_apple",
    version = "3.13.0",
)

# https://github.com/bazelbuild/rules_swift
github_archive(
    name = "build_bazel_rules_swift",
    integrity = "sha256-jrlSxoisDI576ktm9DCbw00427lz4FPW13K52i0HQPE=",
    repo = "bazelbuild/rules_swift",
    version = "2.2.4",
)

# https://github.com/bazelbuild/apple_support
github_archive(
    name = "build_bazel_apple_support",
    integrity = "sha256-nkBofrYnBESl4mMGVm3DmOK6Zva3JTc1JxDeBDSGbGw=",
    repo = "bazelbuild/apple_support",
    version = "1.17.1",
)

load("@build_bazel_apple_support//lib:repositories.bzl", "apple_support_dependencies")
load("@build_bazel_rules_apple//apple:repositories.bzl", "apple_rules_dependencies")
load("@build_bazel_rules_swift//swift:repositories.bzl", "swift_rules_dependencies")

apple_rules_dependencies()

swift_rules_dependencies()

apple_support_dependencies()

# Qt6
# =========================================================

QT_LIBS = [
    "base",
    "svg",
]

[nixpkgs_package(
    name = "qt6.qt%s.out" % lib,
    build_file = "//third_party/qt:BUILD.qt%s.out" % lib,
    repository = "@nixpkgs",
) for lib in QT_LIBS]

[nixpkgs_package(
    name = "qt6.qt%s" % lib,
    build_file = "//third_party/qt:BUILD.qt%s.dev" % lib,
    repository = "@nixpkgs",
) for lib in QT_LIBS]

nixpkgs_package(
    name = "qt",
    attribute_path = "qt6.qttools.dev",
    build_file = "//third_party:BUILD.qt",
    repository = "@nixpkgs",
)

# Node.js
# =========================================================

# https://github.com/bazelbuild/rules_nodejs
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
