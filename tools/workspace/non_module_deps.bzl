load("//tools/workspace:github.bzl", "github_archive", "new_github_archive")
load("//tools/workspace:python.bzl", "python_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:local.bzl", "new_local_repository")
load("@bazel_gazelle//:deps.bzl", "go_repository")
load("@rules_nixpkgs_core//:nixpkgs.bzl", "nixpkgs_package")
load("@rules_haskell//haskell:nixpkgs.bzl", "haskell_register_ghc_nixpkgs")

def _non_module_deps_impl(ctx):
    haskell_register_ghc_nixpkgs(
        name = "rules_haskell",
        attribute_path = "ghc",
        ghcopts = [
            "-j24",
            "-Wall",
            #"-Werror",
            "-XHaskell2010",
            "-fdiagnostics-color=always",
            "-Wno-redundant-constraints",
            "-Wno-unused-imports",
            "-optc=-Wno-unused-command-line-argument",
            "-optl=-Wno-unused-command-line-argument",
            "-optl=-Wl,--no-fatal-warnings",
        ],
        nix_file = "//:ghc.nix",
        register = False,
        repository = "@nixpkgs",
        version = "9.10.3",
    )

    nixpkgs_package(
        name = "bash",
        build_file = "//third_party:bash.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "diffutils",
        build_file = "//third_party:diffutils.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "autoconf",
        build_file = "//third_party:autoconf.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "automake",
        build_file = "//third_party:automake.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "libtool",
        build_file = "//third_party:libtool.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "git",
        build_file = "//third_party:git.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "m4",
        build_file = "//third_party:m4.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "cmake",
        build_file = "//third_party:cmake.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "gnumake",
        build_file = "//third_party:gnumake.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "patchelf",
        build_file = "//third_party:patchelf.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "perl",
        build_file = "//third_party:perl.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "haskellPackages.happy",
        build_file = "//third_party/haskell:happy.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "haskellPackages.alex",
        build_file = "//third_party/haskell:alex.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "haskellPackages.hspec-discover",
        build_file = "//third_party/haskell:hspec-discover.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "haskellPackages.c2hs",
        build_file = "//third_party/haskell:c2hs.BUILD",
        repository = "@nixpkgs",
    )

    # Go packages
    # =========================================================

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

    go_repository(
        name = "org_golang_x_net",
        commit = "7d3dbb06ceb45c3180f4f446cd635e6b59a0b9c2",
        importpath = "golang.org/x/net",
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

    # Python
    # =========================================================

    # https://github.com/python/mypy
    new_github_archive(
        name = "mypy",
        integrity = "sha256-fufY7rOarKQ9K+ZNpnSmlP6LXi71q6Fs7wrzpfyqzKU=",
        repo = "python/mypy",
        version = "v1.14.0",
    )

    # https://github.com/python/mypy_extensions
    new_github_archive(
        name = "mypy_extensions",
        integrity = "sha256-c6N0BjqeVoXZ5CRGK/i6EBPHkWlzPu+9IAEO5dYVenM=",
        repo = "python/mypy_extensions",
        version = "1.0.0",
    )

    # https://github.com/python/typing_extensions
    new_github_archive(
        name = "typing_extensions",
        integrity = "sha256-2H2q0wR96X4PoOpfoj0rpXSND5O2TMDXdefR3w1AkO0=",
        repo = "python/typing_extensions",
        strip_prefix = "/src",
        version = "4.12.2",
    )

    # https://github.com/python/typeshed
    new_github_archive(
        name = "typeshed",
        integrity = "sha256-5xk4xOdabdwespPoOvc6ap1RrBkkTO8FpN3/HsW2f84=",
        repo = "python/typeshed",
        version = "ca6251ad64cf6747c61ed5a453d943264a106008",
    )

    # https://github.com/psf/requests
    new_github_archive(
        name = "requests",
        integrity = "sha256-znCcnHEQmvxtAwizl12rIxwD+0FKxXK8vVXkCQnworM=",
        repo = "psf/requests",
        version = "v2.32.3",
    )

    # https://github.com/urllib3/urllib3
    new_github_archive(
        name = "urllib3",
        integrity = "sha256-Gpe9Lvk9yoizguQQl9kg9dzU795IZsIwX/jq6oL38CE=",
        repo = "urllib3/urllib3",
        version = "2.3.0",
    )

    # https://github.com/kjd/idna
    new_github_archive(
        name = "idna",
        integrity = "sha256-X7o3TgVoDZvi/E+hMSRIHQMYVzuGEqC4yWWL/AJ1ZqU=",
        repo = "kjd/idna",
        version = "v3.10",
    )

    # https://github.com/certifi/python-certifi
    new_github_archive(
        name = "certifi",
        integrity = "sha256-OocLi+9du+EW33fdefMnwv1pLq+D8Ma71DF+iM9BERE=",
        repo = "certifi/python-certifi",
        version = "2024.12.14",
    )

    # https://github.com/chardet/chardet
    new_github_archive(
        name = "chardet",
        integrity = "sha256-hd+/gy8hbRSo710DHqvA7P8bMts6lvn64lKfZCGo/UA=",
        repo = "chardet/chardet",
        version = "5.2.0",
    )

    # C/C++ dependencies
    # =========================================================

    # https://github.com/jedisct1/libsodium/releases
    http_archive(
        name = "libsodium",
        build_file = "//third_party:libsodium.BUILD",
        sha256 = "9e4285c7a419e82dedb0be63a72eea357d6943bc3e28e6735bf600dd4883feaf",
        strip_prefix = "libsodium-1.0.21",
        urls = ["https://github.com/jedisct1/libsodium/releases/download/1.0.21-RELEASE/libsodium-1.0.21.tar.gz"],
    )

    # https://ftp.gnu.org/pub/gnu/ncurses
    http_archive(
        name = "ncurses",
        build_file = "//third_party:ncurses.BUILD",
        integrity = "sha256-E22RvCaamleF5fnpgLx2q1dCj2BM4+WlqQzrx2eXHMY=",
        strip_prefix = "ncurses-6.5",
        urls = [
            "https://invisible-island.net/archives/ncurses/ncurses-6.5.tar.gz",
            "https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.5.tar.gz",
        ],
    )

    http_archive(
        name = "ev",
        build_file = "//third_party:ev.BUILD",
        sha256 = "507eb7b8d1015fbec5b935f34ebed15bf346bed04a11ab82b8eee848c4205aea",
        strip_prefix = "libev-4.33",
        urls = ["http://dist.schmorp.de/libev/libev-4.33.tar.gz"],
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
        build_file = "//third_party:ffmpeg.BUILD",
        sha256 = "fd59e6160476095082e94150ada5a6032d7dcc282fe38ce682a00c18e7820528",
        strip_prefix = "ffmpeg-7.1",
        urls = ["https://ffmpeg.org/releases/ffmpeg-7.1.tar.bz2"],
    )

    # https://github.com/nlohmann/json
    http_archive(
        name = "json",
        build_file = "//third_party:json.BUILD",
        sha256 = "a22461d13119ac5c78f205d3df1db13403e58ce1bb1794edc9313677313f4a9d",
        strip_prefix = "include",
        urls = ["https://github.com/nlohmann/json/releases/download/v3.11.3/include.zip"],
    )

    # https://github.com/simdjson/simdjson/releases
    new_github_archive(
        name = "simdjson",
        integrity = "sha256-hl/62dOtM7ARIHS6iJ7pNNtT1hPq/GOS7A0aDJ5bAFc=",
        repo = "simdjson/simdjson",
        version = "v3.11.6",
    )

    # https://github.com/ianlancetaylor/libbacktrace
    new_github_archive(
        name = "libbacktrace",
        integrity = "sha256-khG7h63XzNymJax129Tp9XJvHpnaVMTxWD0Poh44DJs=",
        repo = "ianlancetaylor/libbacktrace",
        version = "1db85642e3fca189cf4e076f840a45d6934b2456",
    )

    new_github_archive(
        name = "kimageformats",
        integrity = "sha256-MyH1YZz8zHSUL6L6wgqEY7W7GBCYZLckMkaEOcWUgzM=",
        repo = "KDE/kimageformats",
        version = "v6.10.0",
    )

    http_archive(
        name = "libcap",
        build_file = "//third_party:libcap.BUILD",
        sha256 = "db7de848064e656a0bb528dae6d53ff20c82e849d509cecd015a04d2fec8369d",
        strip_prefix = "libcap-2.33",
        urls = ["https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.33.tar.gz"],
    )

    # https://github.com/libexif/libexif
    new_github_archive(
        name = "libexif",
        integrity = "sha256-tsLrkGxLL/VgM1k3AF9M5Ev02UCzGllAcUSI9usAOQU=",
        repo = "libexif/libexif",
        version = "8f013418c2ee71f7aaa81b1699e48d9d3c22dd9b",
    )

    http_archive(
        name = "libidn2",
        build_file = "//third_party:libidn2.BUILD",
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
        sha256 = "4acd4cdd3295658c8cfdf53b67782f6812ab9499913ed2dc9acc03c6cf7329c5",
        version = "openal-soft-1.20.1",
    )

    # https://github.com/cisco/openh264
    new_github_archive(
        name = "openh264",
        repo = "cisco/openh264",
        sha256 = "b1ca643eadbbf16f74c86a66ab487f38691d8dbdda435683b149b2ce2c8077ec",
        version = "v2.6.0",
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
        build_file = "//third_party:pthread_w32.BUILD",
        sha256 = "e6aca7aea8de33d9c8580bcb3a0ea3ec0a7ace4ba3f4e263ac7c7b66bc95fb4d",
        strip_prefix = "pthreads-w32-2-9-1-release",
        urls = ["https://sourceware.org/pub/pthreads-win32/pthreads-w32-2-9-1-release.tar.gz"],
    )

    new_local_repository(
        name = "pthread",
        build_file = "//third_party:pthread.BUILD",
        path = "third_party/pthread",
    )

    new_local_repository(
        name = "psocket",
        build_file_content = """
load("@rules_cc//cc:defs.bzl", "cc_library")

# POSIX networking library.
#
# For Windows, we use the Winsock libraries, for everything else we assume it's
# already exposed by libc.
cc_library(
    name = "psocket",
    linkopts = select({
        "@toktok//tools/config:windows": [
            "-liphlpapi",
            "-lws2_32",
        ],
        "//conditions:default": [],
    }),
    visibility = ["//visibility:public"],
)
""",
        path = "third_party",
    )

    # https://github.com/libunwind/libunwind/releases
    http_archive(
        name = "libunwind",
        build_file = "//third_party:libunwind.BUILD",
        sha256 = "ddf0e32dd5fafe5283198d37e4bf9decf7ba1770b6e7e006c33e6df79e6a6157",
        strip_prefix = "libunwind-1.8.1",
        urls = ["https://github.com/libunwind/libunwind/releases/download/v1.8.1/libunwind-1.8.1.tar.gz"],
    )

    # https://github.com/tukaani-project/xz/releases
    http_archive(
        name = "libxz",
        build_file = "//third_party:libxz.BUILD",
        sha256 = "b1d45295d3f71f25a4c9101bd7c8d16cb56348bbef3bbc738da0351e17c73317",
        strip_prefix = "xz-5.6.3",
        urls = ["https://github.com/tukaani-project/xz/releases/download/v5.6.3/xz-5.6.3.tar.gz"],
    )

    http_archive(
        name = "sdl2",
        build_file = "//third_party:sdl2.BUILD",
        sha256 = "349268f695c02efbc9b9148a70b85e58cefbbf704abd3e91be654db7f1e2c863",
        strip_prefix = "SDL2-2.0.12",
        urls = ["https://github.com/libsdl-org/SDL/releases/download/release-2.0.12/SDL2-2.0.12.tar.gz"],
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
        name = "pandoc",
        attribute_path = "pandoc",
        build_file_content = """
package(default_visibility = ["//visibility:public"])
alias(name = "pandoc", actual = ":bin")
filegroup(name = "bin", srcs = ["bin/pandoc"])
""",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "pkg-config",
        attribute_path = "pkg-config",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "glib",
        attribute_path = "glib.dev",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "chafa",
        attribute_path = "chafa.dev",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "yasm",
        build_file_content = """
package(default_visibility = ["//visibility:public"])
alias(name = "yasm", actual = ":bin")
filegroup(name = "bin", srcs = ["bin/yasm"])
""",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "alsa-lib",
        attribute_path = "alsa-lib",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "asound",
        attribute_path = "alsa-lib.dev",
        build_file = "//third_party:asound.BUILD",
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
        build_file = "//third_party:openssl.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "gettext",
        attribute_path = "gettext",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "xz",
        attribute_path = "xz",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "pcre.out",
        attribute_path = "pcre.out",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "pcre",
        attribute_path = "pcre.dev",
        build_file = "//third_party:pcre.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "gl.out",
        attribute_path = "libGL.out",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "gl",
        attribute_path = "libGL.dev",
        build_file = "//third_party:gl.BUILD",
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
        build_file = "//third_party:glvnd.BUILD",
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
        build_file = "//third_party:x11.BUILD",
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
        build_file = "//third_party:xcb.BUILD",
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
        build_file = "//third_party:xext.BUILD",
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
        build_file = "//third_party:xxf86vm.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "xproto",
        attribute_path = "xorg.xorgproto",
        build_file = "//third_party:xproto.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "xss",
        attribute_path = "xorg.libXScrnSaver",
        build_file = "//third_party:xss.BUILD",
        repository = "@nixpkgs",
    )

    for lib in ["base", "remoteobjects", "svg"]:
        nixpkgs_package(
            name = "qt6.qt" + lib + ".out",
            build_file = "//third_party/qt:qt" + lib + ".out.BUILD",
            repository = "@nixpkgs",
        )
        nixpkgs_package(
            name = "qt6.qt" + lib,
            build_file = "//third_party/qt:qt" + lib + ".dev.BUILD",
            repository = "@nixpkgs",
        )

    nixpkgs_package(
        name = "qt",
        attribute_path = "qt6.qttools.dev",
        build_file = "//third_party:qt.BUILD",
        repository = "@nixpkgs",
    )

    nixpkgs_package(
        name = "python3_config",
        attribute_path = "python313",
        build_file_content = "exports_files(['bin/python3-config'])",
        repository = "@nixpkgs",
    )

    python_repository(
        name = "python3",
        python_config = "@python3_config//:bin/python3-config",
    )

non_module_deps = module_extension(
    implementation = _non_module_deps_impl,
)
