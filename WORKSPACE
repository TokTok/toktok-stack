workspace(name = "toktok")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//tools/workspace:github.bzl", "github_archive", "new_github_archive")

github_archive(
    name = "bazel_toolchains",
    repo = "bazelbuild/bazel-toolchains",
    sha256 = "71148dff099107f4c797eb529ab317e585c6b6624f10bbe9f47960afe0c3cc03",
    version = "r340178",
)

git_repository(
    name = "bazel_skylib",
    remote = "https://github.com/bazelbuild/bazel-skylib.git",
    tag = "0.5.0",
)

# Protobuf
# =========================================================

# proto_library rules implicitly depend on @com_google_protobuf//:protoc,
# which is the proto-compiler.
# This statement defines the @com_google_protobuf repo.
github_archive(
    name = "com_google_protobuf",
    repo = "google/protobuf",
    sha256 = "d7a221b3d4fb4f05b7473795ccea9e05dab3b8721f6286a95fffbffc2d926f8b",
    version = "v3.6.1",
)

# Skydoc
# =========================================================

github_archive(
    name = "io_bazel_skydoc",
    repo = "bazelbuild/skydoc",
    sha256 = "2885adbe581576b2b3ec906eeebc3692e45386651502411284c50979add0fa89",
    version = "0.1.4",
)

load("@io_bazel_skydoc//skylark:skylark.bzl", "skydoc_repositories")

skydoc_repositories()

# Haskell
# =========================================================

github_archive(
    name = "io_tweag_rules_haskell",
    repo = "tweag/rules_haskell",
    sha256 = "854099bec683161b2b6da7e84f29d5f19d095b44fb936332664dcf7b6e9517f1",
    version = "35195f2005226b76e65bed31f1dd815810f94634",
)

load("@io_tweag_rules_haskell//haskell:ghc_bindist.bzl", "ghc_bindist")
load("//third_party/haskell:haskell.bzl", "new_cabal_package")

# This repository rule creates @ghc repository.
ghc_bindist(
    name = "ghc",
)

register_toolchains("//:ghc")

github_archive(
    name = "ai_formation_hazel",
    repo = "FormationAI/hazel",
    sha256 = "3063c822c637f377016afc4a9bc4f263c81a32563a4e1bed539ef2bb493a2183",
    version = "5f8f808402dcdc6570592d2f4c88c94e34a7e7a5",
)

#load("@ai_formation_hazel//:hazel.bzl", "hazel_repositories")
load("//third_party/haskell:packages.bzl", "core_packages", "packages")

# TODO(iphydf): Enable this once hazel is good enough to do automatically what
# we do manually in third_party/haskell.
#hazel_repositories(
#    core_packages = core_packages,
#    packages = packages,
#)

[new_local_repository(
    name = "haskell_%s" % pkg.replace("-", "_"),
    build_file = "third_party/haskell/BUILD.bazel",
    path = "/usr",
) for pkg in core_packages.keys()]

[new_cabal_package(
    package = "%s-%s" % (
        pkg,
        data.version,
    ),
    sha256 = data.sha256,
) for pkg, data in packages.items()]

# Go
# =========================================================

github_archive(
    name = "io_bazel_rules_go",
    repo = "bazelbuild/rules_go",
    sha256 = "f00e32956446f6ee21441e857d96e3295bfb207000c857cf0cf693e1c2dff0fc",
    version = "0.15.3",
)

github_archive(
    name = "bazel_gazelle",
    repo = "bazelbuild/bazel-gazelle",
    sha256 = "d9cb7e3cbaea8efd7bd1c9e27d6aaed335acfbd27e4590bb344baa35032ec612",
    version = "0.14.0",
)

load("@io_bazel_rules_go//go:def.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies", "go_repository")

go_rules_dependencies()

go_register_toolchains()

gazelle_dependencies()

go_repository(
    name = "com_github_streamrail_concurrent_map",
    commit = "master",
    importpath = "github.com/streamrail/concurrent-map",
)

go_repository(
    name = "com_github_petermattis_goid",
    commit = "master",
    importpath = "github.com/petermattis/goid",
)

go_repository(
    name = "com_github_sasha_s_go_deadlock",
    commit = "master",
    importpath = "github.com/sasha-s/go-deadlock",
)

go_repository(
    name = "org_bitbucket_kardianos_osext",
    commit = "tip",
    importpath = "bitbucket.org/kardianos/osext",
)

# C/C++ dependencies
# =========================================================

new_local_repository(
    name = "asound",
    build_file = "third_party/BUILD.asound",
    path = "/usr",
)

new_local_repository(
    name = "ncurses",
    build_file = "third_party/BUILD.ncurses",
    path = "/usr",
)

new_local_repository(
    name = "openal",
    build_file = "third_party/BUILD.openal",
    path = "/usr",
)

new_local_repository(
    name = "opencv",
    build_file = "third_party/BUILD.opencv",
    path = "/usr",
)

new_local_repository(
    name = "sqlite3",
    build_file = "third_party/BUILD.sqlite3",
    path = "/usr",
)

http_archive(
    name = "boringssl",
    #sha256 = "39b512b2a7afb87bb054e16031f9142d5ca9bd1ceebed864b0978c264e11566b",
    urls = ["https://boringssl.googlesource.com/boringssl/+archive/master-with-bazel.tar.gz"],
)

new_http_archive(
    name = "bzip2",
    build_file = "third_party/BUILD.bzip2",
    sha256 = "d70a9ccd8bdf47e302d96c69fecd54925f45d9c7b966bb4ef5f56b770960afa7",
    strip_prefix = "bzip2-1.0.6",
    urls = ["http://http.debian.net/debian/pool/main/b/bzip2/bzip2_1.0.6.orig.tar.bz2"],
)

github_archive(
    name = "com_google_googletest",
    repo = "google/googletest",
    sha256 = "a8e3104c55f0694d4f5db5584286d8f34df00d1426c5dbe3ffd0ccc3ffde7cc5",
    version = "cfe0ae867857dad6d14ff72a2f02808086021f35",
)

new_github_archive(
    name = "curl",
    repo = "curl/curl",
    sha256 = "42f934f3ee450b04fb3f702c4697ccce79b2a5925a9491c60c60ace044c8f46c",
    version = "curl-7_61_0",
)

new_http_archive(
    name = "ffmpeg",
    build_file = "third_party/BUILD.ffmpeg",
    sha256 = "eb0370bf223809b9ebb359fed5318f826ac038ce77933b3afd55ab1a0a21785a",
    strip_prefix = "ffmpeg-3.4.2",
    urls = ["http://ffmpeg.org/releases/ffmpeg-3.4.2.tar.bz2"],
)

new_github_archive(
    name = "filter_audio",
    repo = "irungentoo/filter_audio",
    sha256 = "6e5f3d705d674ba2b692253d67b116daa0c8bc9c8ff7bcaa5e2523a5ad9e8aab",
    version = "v0.0.1",
)

new_http_archive(
    name = "json",
    build_file = "third_party/BUILD.json",
    sha256 = "495362ee1b9d03d9526ba9ccf1b4a9c37691abe3a642ddbced13e5778c16660c",
    strip_prefix = "include",
    urls = ["https://github.com/nlohmann/json/releases/download/v3.1.2/include.zip"],
)

new_http_archive(
    name = "libcap",
    build_file = "third_party/BUILD.libcap",
    sha256 = "4ca80dc6f9f23d14747e4b619fd9784434c570e24a7346f326c692784ed83a86",
    strip_prefix = "libcap-2.25",
    urls = ["https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.25.tar.gz"],
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
    sha256 = "c1d3e1aa8db233e06732b57316f4764657a1159df5839be85646ecd08a788fed",
    version = "a3ec88bd2c7500cdb67fdd926532e426ba401b60",
)

new_http_archive(
    name = "libidn2",
    build_file = "third_party/BUILD.libidn2",
    sha256 = "53f69170886f1fa6fa5b332439c7a77a7d22626a82ef17e2c1224858bb4ca2b8",
    strip_prefix = "libidn2-2.0.5",
    urls = ["https://ftp.gnu.org/gnu/libidn/libidn2-2.0.5.tar.gz"],
)

new_github_archive(
    name = "libqrencode",
    repo = "fukuchi/libqrencode",
    sha256 = "8918db0e158a2f6cd26845b42c6d9d979d16907d65587b1a70c49b9df8dedd14",
    version = "953a31e57b982f049e28dec652bdc2daa748d4c2",
)

new_github_archive(
    name = "libsodium",
    repo = "jedisct1/libsodium",
    sha256 = "bf00beb6dc5fba7703fb4ab4664c332e2b27f8a3a4269e0c7038b58df2cc9886",
    version = "1.0.16",
)

new_github_archive(
    name = "libvpx",
    repo = "webmproject/libvpx",
    sha256 = "1f08b11ef3412f44ad269bf4e14a0b8a514e3e3b86d1642e75cfb542fea96775",
    version = "557fab3678e11e54508bd984dee5673ec57d8da7",
)

new_github_archive(
    name = "libzmq",
    repo = "zeromq/libzmq",
    sha256 = "79d3b5214d9c83639c13e4fd0df0f1fa4fdb60d9581bed834979212c17ad311f",
    version = "2cdad3d0ced9f4ef4d9647cfd60cd697a04ca41a",
)

new_github_archive(
    name = "opus",
    repo = "xiph/opus",
    sha256 = "3306052b378915f69a4b7b19c956b7b3c7ec1519fb4ebfbd5957921b861644c7",
    version = "38fca4a203a6759f2c90b86c84c4db087982ca81",
)

new_http_archive(
    name = "portaudio",
    build_file = "third_party/BUILD.portaudio",
    sha256 = "f5a21d7dcd6ee84397446fa1fa1a0675bb2e8a4a6dceb4305a8404698d8d1513",
    strip_prefix = "portaudio",
    urls = ["http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz"],
)

new_http_archive(
    name = "sndfile",
    build_file = "third_party/BUILD.sndfile",
    sha256 = "1ff33929f042fa333aed1e8923aa628c3ee9e1eb85512686c55092d1e5a9dfa9",
    strip_prefix = "libsndfile-1.0.28",
    urls = ["http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.28.tar.gz"],
)

new_http_archive(
    name = "libxz",
    build_file = "third_party/BUILD.libxz",
    sha256 = "b512f3b726d3b37b6dc4c8570e137b9311e7552e8ccbab4d39d47ce5f4177145",
    strip_prefix = "xz-5.2.4",
    urls = ["https://netix.dl.sourceforge.net/project/lzmautils/xz-5.2.4.tar.gz"],
)

new_http_archive(
    name = "x11",
    build_file = "third_party/BUILD.x11",
    sha256 = "3abce972ba62620611fab5b404dafb852da3da54e7c287831c30863011d28fb3",
    strip_prefix = "libX11-1.6.5",
    urls = ["https://x.org/archive/individual/lib/libX11-1.6.5.tar.gz"],
)

new_http_archive(
    name = "xau",
    build_file = "third_party/BUILD.xau",
    sha256 = "c343b4ef66d66a6b3e0e27aa46b37ad5cab0f11a5c565eafb4a1c7590bc71d7b",
    strip_prefix = "libXau-1.0.8",
    urls = ["https://x.org/archive/individual/lib/libXau-1.0.8.tar.gz"],
)

new_http_archive(
    name = "xcb",
    build_file = "third_party/BUILD.xcb",
    sha256 = "0bb3cfd46dbd90066bf4d7de3cad73ec1024c7325a4a0cbf5f4a0d4fa91155fb",
    strip_prefix = "libxcb-1.13",
    urls = ["https://xcb.freedesktop.org/dist/libxcb-1.13.tar.gz"],
)

new_http_archive(
    name = "xcb_proto",
    build_file = "third_party/BUILD.xcb_proto",
    sha256 = "0698e8f596e4c0dbad71d3dc754d95eb0edbb42df5464e0f782621216fa33ba7",
    strip_prefix = "xcb-proto-1.13",
    urls = ["https://xcb.freedesktop.org/dist/xcb-proto-1.13.tar.gz"],
)

new_http_archive(
    name = "xdmcp",
    build_file = "third_party/BUILD.xdmcp",
    sha256 = "6f7c7e491a23035a26284d247779174dedc67e34e93cc3548b648ffdb6fc57c0",
    strip_prefix = "libXdmcp-1.1.2",
    urls = ["https://x.org/archive/individual/lib/libXdmcp-1.1.2.tar.gz"],
)

new_http_archive(
    name = "xext",
    build_file = "third_party/BUILD.xext",
    sha256 = "eb0b88050491fef4716da4b06a4d92b4fc9e76f880d6310b2157df604342cfe5",
    strip_prefix = "libXext-1.3.3",
    urls = ["https://x.org/archive/individual/lib/libXext-1.3.3.tar.gz"],
)

new_http_archive(
    name = "xss",
    build_file = "third_party/BUILD.xss",
    sha256 = "4f74e7e412144591d8e0616db27f433cfc9f45aae6669c6c4bb03e6bf9be809a",
    strip_prefix = "libXScrnSaver-1.2.3",
    urls = ["https://x.org/archive/individual/lib/libXScrnSaver-1.2.3.tar.gz"],
)

new_http_archive(
    name = "xorgproto",
    build_file = "third_party/BUILD.xorgproto",
    sha256 = "4b951e321ec089ce62ec8347e0fb512735763b315bf19a3467a75df7190435ff",
    strip_prefix = "xorgproto-xorgproto-2018.4",
    urls = ["https://gitlab.freedesktop.org/xorg/proto/xorgproto/-/archive/xorgproto-2018.4/xorgproto-xorgproto-2018.4.tar.gz"],
)

new_github_archive(
    name = "yasm",
    repo = "yasm/yasm",
    sha256 = "17a74037d2893c2327e00a263219a265f9e2a072445d44fd88c74d5a7e501d2a",
    version = "e256985c4929f4e550d8f70cad5fb936f81b7b06",
)

new_github_archive(
    name = "zlib",
    repo = "madler/zlib",
    sha256 = "f5cc4ab910db99b2bdbba39ebbdc225ffc2aa04b4057bc2817f1b94b6978cfc3",
    version = "v1.2.11",
)

# Maven dependencies
# =========================================================

load("@bazel_tools//tools/build_defs/repo:maven_rules.bzl", "maven_aar")

local_repository(
    name = "org_bytedeco_javacpp_presets_ffmpeg_platform",
    path = "third_party/javacpp/ffmpeg",
)

local_repository(
    name = "org_bytedeco_javacpp_presets_opencv_platform",
    path = "third_party/javacpp/opencv",
)

maven_aar(
    name = "com_timehop_stickyheadersrecyclerview_library",
    artifact = "com.timehop.stickyheadersrecyclerview:library:0.4.3",
    sha1 = "44a237a0ebff7c7ebb10c79698f97f6d635d0e26",
)

maven_aar(
    name = "com_tonicartos_superslim",
    artifact = "com.tonicartos:superslim:0.4.13",
    sha1 = "b05a0931a2d97fd370dc4ae6e003a9f57eada69a",
)

maven_aar(
    name = "de_hdodenhof_circleimageview",
    artifact = "de.hdodenhof:circleimageview:2.1.0",
    sha1 = "c0fcd515432ccb654bc5b44af60320703880a0f6",
)

maven_aar(
    name = "com_sothree_slidinguppanel_library",
    artifact = "com.sothree.slidinguppanel:library:3.4.0",
    sha1 = "a46c103238d666c097f6fefcffb479ebb450d365",
)

maven_jar(
    name = "com_chuusai_shapeless",
    artifact = "com.chuusai:shapeless_2.11:2.3.3",
    sha1 = "ea34d4b6128b9090386945dcb952816bd9e87ce2",
)

maven_jar(
    name = "com_google_guava_guava",
    artifact = "com.google.guava:guava:19.0",
    sha1 = "6ce200f6b23222af3d8abb6b6459e6c44f4bb0e9",
)

maven_jar(
    name = "com_intellij_annotations",
    artifact = "com.intellij:annotations:12.0",
    sha1 = "bbcf6448f6d40abe506e2c83b70a3e8bfd2b4539",
)

maven_jar(
    name = "com_typesafe_scala_logging_scala_logging",
    artifact = "com.typesafe.scala-logging:scala-logging_2.11:3.7.2",
    sha1 = "5015fe84c5aec4f8eb3daa2d1663d447d65f8c02",
)

maven_jar(
    name = "junit_junit",
    artifact = "junit:junit:4.12",
    sha1 = "2973d150c0dc1fefe998f834810d68f278ea58ec",
)

maven_jar(
    name = "log4j_log4j",
    artifact = "log4j:log4j:1.2.17",
    sha1 = "5af35056b4d257e4b64b9e8069c0746e8b08629f",
)

maven_jar(
    name = "org_apache_commons_commons_lang3",
    artifact = "org.apache.commons:commons-lang3:3.4",
    sha1 = "5fe28b9518e58819180a43a850fbc0dd24b7c050",
)

maven_jar(
    name = "org_bytedeco_javacpp",
    artifact = "org.bytedeco:javacpp:1.4",
    sha1 = "6e9062d70f863a4e55b3827d42d302f94e89d7e5",
)

maven_jar(
    name = "org_bytedeco_javacpp_presets_ffmpeg",
    artifact = "org.bytedeco.javacpp-presets:ffmpeg:3.4.1-1.4",
    sha1 = "bf46f2d74014475c948f1a8e063fae50ab724520",
)

maven_jar(
    name = "org_bytedeco_javacpp_presets_opencv",
    artifact = "org.bytedeco.javacpp-presets:opencv:3.4.0-1.4",
    sha1 = "b82eeed2295f30369044b2520937d764efeb3e1e",
)

maven_jar(
    name = "org_bytedeco_javacv",
    artifact = "org.bytedeco:javacv:1.4",
    sha1 = "c443d8c648fb7e53428837e469ced47369a297af",
)

maven_jar(
    name = "org_bytedeco_javacv_platform",
    artifact = "org.bytedeco:javacv-platform:1.4",
    sha1 = "9a674bb8266e02f6c85b6f5644b7eab13119f14e",
)

maven_jar(
    name = "org_scalacheck_scalacheck",
    artifact = "org.scalacheck:scalacheck_2.11:1.14.0",
    sha1 = "60087bb4b94537ad2b4955559a8ead7bac5c615d",
)

maven_jar(
    name = "org_slf4j_slf4j_api",
    artifact = "org.slf4j:slf4j-api:1.7.25",
    sha1 = "da76ca59f6a57ee3102f8f9bd9cee742973efa8a",
)

maven_jar(
    name = "org_slf4j_slf4j_android",
    artifact = "org.slf4j:slf4j-android:1.7.22",
    sha1 = "74825860214ed889b38d0fc865b89af18f4e95a7",
)

maven_jar(
    name = "org_slf4j_slf4j_log4j12",
    artifact = "org.slf4j:slf4j-log4j12:1.7.22",
    sha1 = "3bb94b26c2ad2f8755302aa9bf96f03b23a76639",
)

# Scala toolchain
# =========================================================

github_archive(
    name = "io_bazel_rules_scala",
    repo = "bazelbuild/rules_scala",
    sha256 = "070029464aa9ccf6b48efd691150757c026be85cebac54e04c2fcfd96754e004",
    version = "9801202b2c82f6ad7da85b014a84f9354853f479",
)

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")

scala_register_toolchains()

scala_repositories()

scala_proto_repositories()

git_repository(
    name = "gmaven_rules",
    commit = "e593e3a0baebadd7e95ddd70525201dfa6277d04",
    remote = "https://github.com/aj-michael/gmaven_rules",
)

load("@gmaven_rules//:gmaven.bzl", "gmaven_rules")

gmaven_rules()

android_sdk_repository(
    name = "androidsdk",
    api_level = 28,
    build_tools_version = "28.0.2",
    path = "third_party/android/sdk",
)

android_ndk_repository(
    name = "androidndk",
    api_level = 25,
    path = "third_party/android/android-ndk-r14b",
)

# Qt5
# =========================================================

new_local_repository(
    name = "qt",
    build_file = "third_party/BUILD.qt",
    path = "third_party/qt",
)

# x264
# =========================================================

new_local_repository(
    name = "x264",
    build_file = "third_party/BUILD.x264",
    path = "/usr",
)

# Python
# =========================================================

load("//tools/workspace:python.bzl", "python_repository")

python_repository(
    name = "python2",
    version = "2.7",
)

python_repository(
    name = "python3",
    version = "3.5",
)

# Node.js
# =========================================================

github_archive(
    name = "org_pubref_rules_node",
    repo = "pubref/rules_node",
    sha256 = "3737c9bf90331c3b5b803f6d40c408fcb721a86a474f73f6a85de0fcf6e55bac",
    version = "1c60708c599e6ebd5213f0987207a1d854f13e23",
)

load("@org_pubref_rules_node//node:rules.bzl", "node_repositories", "yarn_modules")

node_repositories()

yarn_modules(
    name = "yarn_modules",
    install_tools = [
        "sh",
        "dirname",
    ],
    deps = {
        "ansi-to-html": "0.6.4",
        "async": "2.6.0",
        "buffertools": "2.1.6",
        "ffi": "2.2.0",
        "firebase": "3.9.0",
        "firepad": "1.4.0",
        "grunt": "1.0.1",
        "grunt-jsdoc": "2.2.1",
        "grunt-shell": "2.1.0",
        "ink-docstrap": "1.3.2",
        "jsdoc": "3.5.5",
        "mktemp": "0.4.0",
        "mocha": "3.5.3",
        "ref": "1.3.5",
        "ref-array": "1.2.0",
        "ref-struct": "1.1.0",
        "should": "13.2.1",
        "underscore": "1.8.3",
    },
)

yarn_modules(
    name = "mocha_modules",
    deps = {"mocha": "3.5.3"},
)
