workspace(name = "toktok")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//tools/workspace:github.bzl", "github_archive", "new_github_archive")

github_archive(
    name = "bazel_skylib",
    repo = "bazelbuild/bazel-skylib",
    sha256 = "4060f1efdb6e12e72dd531700271e281e66f5fd46a708bbfadba194588111f42",
    version = "652c8f0b2817daaa2570b7a3b2147643210f7dc7",
)

# Fuzzing
# =========================================================

http_archive(
    name = "rules_fuzzing",
    sha256 = "c0dc1f90dea236299271e558d8303dd4cc8c7554b2b0639561e5007d2d33328e",
    strip_prefix = "rules_fuzzing-0.4.0",
    urls = ["https://github.com/bazelbuild/rules_fuzzing/archive/v0.4.0.zip"],
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
    sha256 = "2c6388e97cb4fb30546d65e983c45bb422bfe32c6e946af329cd1c52f1eaf836",
    version = "v0.39.1",
)

github_archive(
    name = "bazel_gazelle",
    repo = "bazelbuild/bazel-gazelle",
    sha256 = "1e246edb247c76ddf698ddc58fec7d3a9f908131b356133e6dccf91194d47aee",
    version = "v0.33.0",
)

load("@io_bazel_rules_go//go:deps.bzl", "go_rules_dependencies")

go_rules_dependencies()

# Haskell
# =========================================================

github_archive(
    name = "rules_haskell",
    repo = "tweag/rules_haskell",
    sha256 = "dfb99ad2788a65bba2400b7801c3241839220c033eb41a141f7fc434f4796543",
    version = "48df56b32710e7894079cde1a91b2701667fa518",
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
    "nixpkgs_package",
    "nixpkgs_python_configure",
)
load(
    "@io_tweag_rules_nixpkgs//toolchains/go:go.bzl",
    "nixpkgs_go_configure",
)

nixpkgs_git_repository(
    name = "nixpkgs",
    revision = "23.05",
    sha256 = "f2b96094f6dfbb53b082fe8709da94137475fcfead16c960f2395c98fc014b68",
)

nixpkgs_cc_configure(
    attribute_path = "clang_16",
    repository = "@nixpkgs",
)

nixpkgs_go_configure(
    repository = "@nixpkgs",
)

nixpkgs_python_configure(
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "diffutils",
    build_file = "//third_party:BUILD.diffutils",
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

load(
    "@rules_haskell//haskell:nixpkgs.bzl",
    "haskell_register_ghc_nixpkgs",
)

# Fetch a GHC binary distribution from nixpkgs and register it as a toolchain.
# For more information:
# https://api.haskell.build/haskell/nixpkgs.html#haskell_register_ghc_nixpkgs
haskell_register_ghc_nixpkgs(
    attribute_path = "ghc",
    nix_file = "//:ghc.nix",
    repositories = {"nixpkgs": "@nixpkgs"},
    version = "9.2.7",
    #static_runtime = True,
    #fully_static_link = True,
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
    sha256 = "263000d4afc2a7a26dd75fe23fc86535c73785984ab053b4dfb231caa76b03d6",
    version = "89b25572dbd7668499d2cfd01dea905f8c44e019",
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
    sha256 = "47d062731c9f66a78380e35a19aac77cebceccd1c7cc309b9c82343ffc430c3d",
    strip_prefix = "ffmpeg-6.0",
    urls = ["https://ffmpeg.org/releases/ffmpeg-6.0.tar.bz2"],
)

http_archive(
    name = "gettext",
    build_file = "@toktok//third_party:BUILD.gettext",
    sha256 = "66415634c6e8c3fa8b71362879ec7575e27da43da562c798a8a2f223e6e47f5c",
    strip_prefix = "gettext-0.20.1",
    urls = ["https://ftp.gnu.org/pub/gnu/gettext/gettext-0.20.1.tar.gz"],
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
    sha256 = "ab58566242d0abc2c54592cc35eca00cf51cc91985f3c1fbd372fb2428a7195a",
    version = "e5cbbafe5bd2052829176d05f2fac00ca9dbe4b8",
)

new_github_archive(
    name = "libsodium",
    patches = ["@toktok//third_party/patches:libsodium.patch"],
    repo = "jedisct1/libsodium",
    sha256 = "1b72c0cdbc535ce42e14ac15e8fc7c089a3ee9ffe5183399fd77f0f3746ea794",
    version = "1.0.18",
)

new_github_archive(
    name = "libvpx",
    repo = "webmproject/libvpx",
    sha256 = "58486af4ae5d8fdd8fbdd71c242093755fe38dcc4f40c24d1e2a23f052a60fc1",
    version = "v1.13.0",
)

new_github_archive(
    name = "libzmq",
    repo = "zeromq/libzmq",
    sha256 = "710cbbbd97cd8ab6831466d8d4f2e9f491efacf34c24c72183c4e6428e203300",
    version = "v4.3.2",
)

new_github_archive(
    name = "openal",
    repo = "kcat/openal-soft",
    sha256 = "4acd4cdd3295658c8cfdf53b67782f6812ab9499913ed2dc9acc03c6cf7329c5",
    version = "openal-soft-1.20.1",
)

new_github_archive(
    name = "opus",
    patches = ["@toktok//third_party/patches:opus.patch"],
    repo = "xiph/opus",
    sha256 = "dd991a0a8ecf885b147297290b3585c16d236e2c2283272ecaa7778dae524292",
    version = "a8e6a77c5fe0c37aa6788f939f24f8cd22ae2652",
)

http_archive(
    name = "portaudio",
    build_file = "@toktok//third_party:BUILD.portaudio",
    sha256 = "f5a21d7dcd6ee84397446fa1fa1a0675bb2e8a4a6dceb4305a8404698d8d1513",
    strip_prefix = "portaudio",
    urls = ["http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz"],
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
    name = "sndfile",
    build_file = "@toktok//third_party:BUILD.sndfile",
    sha256 = "1ff33929f042fa333aed1e8923aa628c3ee9e1eb85512686c55092d1e5a9dfa9",
    strip_prefix = "libsndfile-1.0.28",
    urls = ["http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.28.tar.gz"],
)

http_archive(
    name = "libxz",
    build_file = "@toktok//third_party:BUILD.libxz",
    sha256 = "b512f3b726d3b37b6dc4c8570e137b9311e7552e8ccbab4d39d47ce5f4177145",
    strip_prefix = "xz-5.2.4",
    urls = ["https://netix.dl.sourceforge.net/project/lzmautils/xz-5.2.4.tar.gz"],
)

http_archive(
    name = "sdl2",
    build_file = "@toktok//third_party:BUILD.sdl2",
    sha256 = "349268f695c02efbc9b9148a70b85e58cefbbf704abd3e91be654db7f1e2c863",
    strip_prefix = "SDL2-2.0.12",
    urls = ["https://www.libsdl.org/release/SDL2-2.0.12.tar.gz"],
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
    sha256 = "1a8be062395d830f136cfcefde78495c220c69f5de60f3c38ce225c1dba17f11",
    version = "ed918cb027572a80468457db906cbb132f29b920",
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
    sha256 = "0f603cc12658ef1f22da47b729ca987d43fad08a61a22b4539ad2e6460fc7263",
    version = "3.0.2",
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
