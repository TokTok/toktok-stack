workspace(name = "toktok")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//tools/workspace:github.bzl", "github_archive", "new_github_archive")

github_archive(
    name = "bazel_toolchains",
    repo = "bazelbuild/bazel-toolchains",
    sha256 = "14daf97c62e0bb3b3aca2cc2d12f1d69c31c53f0a7417b6a9fd91ce6fdbebecd",
    version = "2.2.2",
)

github_archive(
    name = "rules_cc",
    repo = "bazelbuild/rules_cc",
    sha256 = "523c59bb3f16518679668594c8874da46872fde05c32ba246bc0a35ec292f8a6",
    version = "34ca16f4aa4bf2a5d3e4747229202d6cb630ebab",
)

github_archive(
    name = "rules_java",
    repo = "bazelbuild/rules_java",
    sha256 = "7f4772b0ee2b46a042870c844e9c208e8a0960a953a079236a4bbd785e471275",
    version = "9eb38ebffbaf4414fa3d2292b28e604a256dd5a5",
)

github_archive(
    name = "rules_proto",
    repo = "bazelbuild/rules_proto",
    sha256 = "26252c7c072c92e309ea48ed81d2e56fba82403da00d09c7ef64e0256580f142",
    version = "218ffa7dfa5408492dc86c01ee637614f8695c45",
)

github_archive(
    name = "rules_python",
    repo = "bazelbuild/rules_python",
    sha256 = "d3e40ca3b7e00b72d2b1585e0b3396bcce50f0fc692e2b7c91d8b0dc471e3eaf",
    version = "748aa53d7701e71101dfd15d800e100f6ff8e5d1",
)

github_archive(
    name = "bazel_skylib",
    repo = "bazelbuild/bazel-skylib",
    sha256 = "d786769a4c9bfd9d5fe7933cf70d8c9da506a49c9f24a8471d64de2ac529274a",
    version = "6970e21d290ceaa36502d0c94533b26e5ec18c0b",
)

# Protobuf
# =========================================================

# proto_library rules implicitly depend on @com_google_protobuf//:protoc,
# which is the proto-compiler.
# This statement defines the @com_google_protobuf repo.
github_archive(
    name = "com_google_protobuf",
    repo = "protocolbuffers/protobuf",
    sha256 = "9748c0d90e54ea09e5e75fb7fac16edce15d2028d4356f32211cfa3c0e956564",
    version = "v3.11.4",
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

# Haskell
# =========================================================

github_archive(
    name = "rules_nixpkgs",
    repo = "tweag/rules_nixpkgs",
    sha256 = "3a2d245e60d41c139cf5d1bb6f5a358c0c8a4d26325285af8ed092b078fb6b1d",
    version = "v0.5.2",
)

github_archive(
    name = "rules_sh",
    repo = "tweag/rules_sh",
    sha256 = "93fb94bec4228971343b1ecbb303450ff323f52c768d60eeb3a445acfa6328ff",
    version = "0c274ad480ed3eade49250abd04ff71655a07820",
)

github_archive(
    name = "rules_haskell",
    repo = "tweag/rules_haskell",
    sha256 = "b72c6f92b4cac0af92d91f35f4b392874805e07d412abaeeefc63e5b9b29cdb5",
    version = "827d654235189242b0a9d45df8bc8754469b4579",
)

load("@rules_haskell//haskell:ghc_bindist.bzl", "haskell_register_ghc_bindists")
load("@rules_haskell//haskell:repositories.bzl", "haskell_repositories")

haskell_repositories()

# This repository rule creates @ghc repository.
haskell_register_ghc_bindists(
    compiler_flags = [
        "-Wall",
        "-Werror",
        "-optP=-Wno-trigraphs",
        "-fdiagnostics-color=always",
    ],
    version = "8.6.5",
)

github_archive(
    name = "ai_formation_hazel",
    repo = "FormationAI/hazel",
    sha256 = "db5466c442c228cffab14c51daff46a7861fdea3ef62be3e80ccd4b8dc60ab3e",
    version = "fe4b139751951f9489434f3f26e96598a1afebe1",
)

load("@ai_formation_hazel//tools:mangling.bzl", "hazel_workspace")

#load("@ai_formation_hazel//:hazel.bzl", "hazel_repositories")
load("//third_party/haskell:haskell.bzl", "new_cabal_package")
load("//third_party/haskell:packages.bzl", "core_packages", "packages")

# TODO(iphydf): Enable this once hazel is good enough to do automatically what
# we do manually in third_party/haskell.
#hazel_repositories(
#    core_packages = core_packages,
#    packages = packages,
#)

[new_local_repository(
    name = hazel_workspace(pkg),
    build_file = "third_party/haskell/BUILD.bazel",
    path = "third_party/haskell",
) for pkg in core_packages.keys()]

[new_cabal_package(
    package = "%s-%s" % (
        pkg,
        data.version,
    ),
    sha256 = data.sha256,
) for pkg, data in packages.items()]

# Skydoc
# =========================================================

github_archive(
    name = "io_bazel_skydoc",
    repo = "bazelbuild/skydoc",
    sha256 = "6b9ab4cf5c781e467888ce14864e62f47adc4b6d0cb7a9838469440d25643a4b",
    version = "0.2.0",
)

load("@io_bazel_skydoc//skylark:skylark.bzl", "skydoc_repositories")

skydoc_repositories()

# Go
# =========================================================

github_archive(
    name = "io_bazel_rules_go",
    repo = "bazelbuild/rules_go",
    sha256 = "9fbaffc63aa802496b0de6ed708fce8fb4c34b27fa7fab6cfc64eeae900c19a7",
    version = "v0.22.1",
)

github_archive(
    name = "bazel_gazelle",
    repo = "bazelbuild/bazel-gazelle",
    sha256 = "8d2880d411e8461bab87c8bd239bf1b7ac2301f1af49f2b581ecc5cdc24b7206",
    version = "v0.20.0",
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
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
    name = "com_github_kardianos_osext",
    commit = "master",
    importpath = "github.com/kardianos/osext",
)

# C/C++ dependencies
# =========================================================

load("//tools/workspace:local.bzl", "local_library_repository")

local_library_repository(
    name = "asound",
    version = "2.0",
)

local_library_repository(
    name = "ncurses",
    version = "6.2",
)

local_library_repository(
    name = "x264",
    version = "r2917_1",
)

# TODO(iphydf): We can't build boringssl in bazel yet, because Qt links
# against openssl from the system, while we link against our local boringssl.
# This causes issues with global initialisation where one library thinks it's
# initialised but the state is in the other library. Note that this only
# happens with dynamic linking. If we link statically (we do for binaries, but
# not for tests), this works fine.
#github_archive(
#    name = "boringssl",
#    repo = "google/boringssl",
#    sha256 = "99cf9dec3f789373a896531a267244e6853526084b9a32c2cf49faf16492c36c",
#    version = "4984d802d95bb709ab824e07ffb2d61441b8348f",
#)

local_library_repository(
    name = "openssl",
    brew_name = "openssl@1.1",
    libs = [
        "crypto",
        "ssl",
    ],
    version = "1.1.1f",
)

new_local_repository(
    name = "boringssl",
    build_file = "@toktok//third_party:BUILD.boringssl",
    path = "third_party",
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
    sha256 = "b18016e313e0a635b643371f8a33f9813103b600e894f71e8625f0b8215ae698",
    version = "e588eb1ff9ff6598666279b737b27f983156ad85",
)

new_github_archive(
    name = "curl",
    repo = "curl/curl",
    sha256 = "3dc2825102eaed44b84613a98486aac8f924742d8fcf329bf2b49dc42c4ef93a",
    version = "curl-7_69_1",
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
    sha256 = "b620d187c26f76ca19e74210a0336c3b8380b97730df5cdf45f3e69e89000e5c",
    strip_prefix = "ffmpeg-4.2.2",
    urls = ["https://ffmpeg.org/releases/ffmpeg-4.2.2.tar.bz2"],
)

#new_local_repository(
#    name = "ffmpeg",
#    build_file = "@toktok//third_party:BUILD.ffmpeg",
#    path = "third_party/ffmpeg/ffmpeg-4.2.2",
#)

http_archive(
    name = "gettext",
    build_file = "@toktok//third_party:BUILD.gettext",
    #sha256 = "87b5884741427220d3a33df1363ae0e8b898099fbc59f1c451113f6732891014",
    strip_prefix = "gettext-0.20.1",
    urls = ["https://ftp.gnu.org/pub/gnu/gettext/gettext-0.20.1.tar.gz"],
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
    sha256 = "b43387df5a3866836c2a1bc141889af1d977c2e0c17e718b1b27fd1b002cb551",
    version = "54b6f7fb6ae1d08602f9f7c44e0624c8344ee832",
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
    repo = "jedisct1/libsodium",
    sha256 = "1b72c0cdbc535ce42e14ac15e8fc7c089a3ee9ffe5183399fd77f0f3746ea794",
    version = "1.0.18",
)

new_github_archive(
    name = "libvpx",
    repo = "webmproject/libvpx",
    sha256 = "9032e21faf6e26dc298ed0cbbb2a5bec732b55c93effff6746c59a3afb356198",
    version = "e20be1b2340dd3115cd445eafd9c1c717b621298",
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
    repo = "xiph/opus",
    sha256 = "24ee6eb416b3bf15785e0c6a8d08b046f6a1d32e4c677908de314b5f841d2d6e",
    version = "83d5155f151ca47c9d6274ded1a7481f746b9a43",
)

http_archive(
    name = "portaudio",
    build_file = "@toktok//third_party:BUILD.portaudio",
    sha256 = "f5a21d7dcd6ee84397446fa1fa1a0675bb2e8a4a6dceb4305a8404698d8d1513",
    strip_prefix = "portaudio",
    urls = ["http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz"],
)

http_archive(
    name = "pthread",
    build_file = "@toktok//third_party:BUILD.pthread",
    sha256 = "e6aca7aea8de33d9c8580bcb3a0ea3ec0a7ace4ba3f4e263ac7c7b66bc95fb4d",
    strip_prefix = "pthreads-w32-2-9-1-release",
    urls = ["https://sourceware.org/pub/pthreads-win32/pthreads-w32-2-9-1-release.tar.gz"],
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
    patches = ["@toktok//third_party/patches:sqlcipher.patch"],
    repo = "sqlcipher/sqlcipher",
    sha256 = "41e1408465488e9c478ca5b7c5f8410405a10caa73b82db60ac115a76c563c05",
    version = "v4.3.0",
)

new_github_archive(
    name = "tcl",
    repo = "tcltk/tcl",
    sha256 = "14e45a20a839fd13cc067244db668851465f970661f831ab8eabb7233e664221",
    version = "1771deb31e24580d6a7cdedcb68ccfcdb89eb384",
)

http_archive(
    name = "x11",
    build_file = "@toktok//third_party:BUILD.x11",
    sha256 = "b8c0930a9b25de15f3d773288cacd5e2f0a4158e194935615c52aeceafd1107b",
    strip_prefix = "libX11-1.6.9",
    urls = ["https://www.x.org/releases/individual/lib/libX11-1.6.9.tar.gz"],
)

http_archive(
    name = "xau",
    build_file = "@toktok//third_party:BUILD.xau",
    sha256 = "1f123d8304b082ad63a9e89376400a3b1d4c29e67e3ea07b3f659cccca690eea",
    strip_prefix = "libXau-1.0.9",
    urls = ["https://www.x.org/releases/individual/lib/libXau-1.0.9.tar.gz"],
)

http_archive(
    name = "xcb",
    build_file = "@toktok//third_party:BUILD.xcb",
    sha256 = "2c7fcddd1da34d9b238c9caeda20d3bd7486456fc50b3cc6567185dbd5b0ad02",
    strip_prefix = "libxcb-1.14",
    urls = ["https://www.x.org/releases/individual/lib/libxcb-1.14.tar.gz"],
)

http_archive(
    name = "xcb_proto",
    build_file = "@toktok//third_party:BUILD.xcb_proto",
    sha256 = "1c3fa23d091fb5e4f1e9bf145a902161cec00d260fabf880a7a248b02ab27031",
    strip_prefix = "xcb-proto-1.14",
    urls = ["https://www.x.org/releases/individual/proto/xcb-proto-1.14.tar.gz"],
)

http_archive(
    name = "xdmcp",
    build_file = "@toktok//third_party:BUILD.xdmcp",
    sha256 = "2ef9653d32e09d1bf1b837d0e0311024979653fe755ad3aaada8db1aa6ea180c",
    strip_prefix = "libXdmcp-1.1.3",
    urls = ["https://www.x.org/releases/individual/lib/libXdmcp-1.1.3.tar.gz"],
)

http_archive(
    name = "xext",
    build_file = "@toktok//third_party:BUILD.xext",
    sha256 = "8ef0789f282826661ff40a8eef22430378516ac580167da35cc948be9041aac1",
    strip_prefix = "libXext-1.3.4",
    urls = ["https://www.x.org/releases/individual/lib/libXext-1.3.4.tar.gz"],
)

http_archive(
    name = "xss",
    build_file = "@toktok//third_party:BUILD.xss",
    sha256 = "4f74e7e412144591d8e0616db27f433cfc9f45aae6669c6c4bb03e6bf9be809a",
    strip_prefix = "libXScrnSaver-1.2.3",
    urls = ["https://www.x.org/releases/individual/lib/libXScrnSaver-1.2.3.tar.gz"],
)

http_archive(
    name = "xorgproto",
    build_file = "@toktok//third_party:BUILD.xorgproto",
    sha256 = "ebfcfce48b66bec25d5dff0e9510e04053ef78e51a8eabeeee4c00e399226d61",
    strip_prefix = "xorgproto-2019.2",
    urls = ["https://www.x.org/releases/individual/proto/xorgproto-2019.2.tar.gz"],
)

http_archive(
    name = "xproto",
    build_file = "@toktok//third_party:BUILD.xproto",
    sha256 = "6d755eaae27b45c5cc75529a12855fed5de5969b367ed05003944cf901ed43c7",
    strip_prefix = "xproto-7.0.31",
    urls = ["https://www.x.org/releases/individual/proto/xproto-7.0.31.tar.gz"],
)

new_github_archive(
    name = "yasm",
    repo = "yasm/yasm",
    sha256 = "e8123135c857ca3a0511854e0709e04f345925ab196ee6c73112dc9fa8b41690",
    version = "ea8f2393611025c5d32ddfe022dddff5a1a5c989",
)

# Apple frameworks
# =========================================================

github_archive(
    name = "build_bazel_rules_apple",
    # TODO(https://github.com/bazelbuild/rules_apple/issues/737): Remove.
    patches = ["@toktok//third_party/patches:rules_apple.patch"],
    repo = "bazelbuild/rules_apple",
    sha256 = "49618def769ec2bf6f33d9f51479e5fdb8ef55f6ba156f2a14021e02d32f313a",
    version = "524ea38c7c1f8a14bdea812f499aea7c5d3d1e13",
)

github_archive(
    name = "build_bazel_rules_swift",
    repo = "bazelbuild/rules_swift",
    sha256 = "1263206c029b7a162bda0092fca1ade2b8873e56bf122a1f15a0d6cb95d6f0e8",
    version = "7336f68990c3a2779186a7157bf29036023d3246",
)

github_archive(
    name = "build_bazel_apple_support",
    repo = "bazelbuild/apple_support",
    sha256 = "8aa07a6388e121763c0164624feac9b20841afa2dd87bac0ba0c3ed1d56feb70",
    version = "501b4afb27745c4813a88ffa28acd901408014e4",
)

load("@build_bazel_rules_apple//apple:repositories.bzl", "apple_rules_dependencies")
load("@build_bazel_rules_swift//swift:repositories.bzl", "swift_rules_dependencies")
load("@build_bazel_apple_support//lib:repositories.bzl", "apple_support_dependencies")

apple_rules_dependencies()

swift_rules_dependencies()

apple_support_dependencies()

# JUnit5
# =========================================================

load("//tools/workspace:junit5.bzl", "junit_jupiter_java_repositories", "junit_platform_java_repositories")

junit_jupiter_java_repositories()

junit_platform_java_repositories()

# Maven dependencies
# =========================================================

github_archive(
    name = "rules_jvm_external",
    repo = "bazelbuild/rules_jvm_external",
    sha256 = "8ba00db3da4c65a37050a95ca17551cf0956ef33b0c35f7cc058c5d8f33dd59c",
    version = "bad9e2501279aea5268b1b8a5463ccc1be8ddf65",
)

load("@rules_jvm_external//:defs.bzl", "maven_install")

local_repository(
    name = "org_bytedeco_javacpp_presets_ffmpeg_platform",
    path = "third_party/javacpp/ffmpeg",
)

local_repository(
    name = "org_bytedeco_javacpp_presets_opencv_platform",
    path = "third_party/javacpp/opencv",
)

maven_install(
    artifacts = [
        "androidx.appcompat:appcompat:1.1.0",
        "androidx.cardview:cardview:1.0.0",
        "androidx.constraintlayout:constraintlayout:1.1.3",
        "androidx.test:rules:1.2.0",
        "androidx.test.ext:junit:1.1.1",
        "androidx.test.espresso:espresso-core:3.2.0",
        "com.google.android.material:material:1.1.0",
        "com.chuusai:shapeless_2.11:2.3.3",
        "com.google.guava:guava:19.0",
        "com.typesafe.scala-logging:scala-logging_2.11:3.7.2",
        "de.hdodenhof:circleimageview:3.1.0",
        "junit:junit:4.13",
        "log4j:log4j:1.2.17",
        "org.apache.commons:commons-lang3:3.4",
        "org.bytedeco:javacpp:1.4",
        "org.bytedeco.javacpp-presets:ffmpeg:3.4.1-1.4",
        "org.bytedeco.javacpp-presets:opencv:3.4.0-1.4",
        "org.bytedeco:javacv:1.4",
        "org.bytedeco:javacv-platform:1.4",
        "org.jetbrains:annotations:13.0",
        "org.scalacheck:scalacheck_2.11:1.14.0",
        "org.scala-lang.modules:scala-swing_2.11:2.1.1",
        "org.slf4j:slf4j-android:1.7.30",
        "org.slf4j:slf4j-api:1.7.25",
        "org.slf4j:slf4j-log4j12:1.7.22",
    ],
    repositories = [
        "https://maven.google.com",
        "https://repo1.maven.org/maven2",
    ],
)

# Scala toolchain
# =========================================================

github_archive(
    name = "io_bazel_rules_scala",
    repo = "bazelbuild/rules_scala",
    sha256 = "6be7a3e4a174590c069f502217a05437caf32ccaaea8ceb16d338f3af292c016",
    version = "0bb4bcb38359707157b823c2b0e7ad2370c90d8d",
)

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")
load("@io_bazel_rules_scala//scala_proto:toolchains.bzl", "scala_proto_register_enable_all_options_toolchain")

scala_register_toolchains()

scala_repositories()

scala_proto_repositories()

scala_proto_register_enable_all_options_toolchain()

# Android
# =========================================================

github_archive(
    name = "rules_android",
    repo = "bazelbuild/rules_android",
    sha256 = "cd06d15dd8bb59926e4d65f9003bfc20f9da4b2519985c27e190cddc8b7a7806",
    version = "v0.1.1",
)

android_sdk_repository(
    name = "androidsdk",
    api_level = 28,
    build_tools_version = "29.0.2",
    path = "third_party/android/sdk",
)

android_ndk_repository(
    name = "androidndk",
    api_level = 25,
    path = "third_party/android/android-ndk-r16b",
)

github_archive(
    name = "android_test_support",
    repo = "android/android-test",
    sha256 = "dad9ccda5a017a9fbe624c46d50ef88b4e3e4f9ad8657c820d79a83d9328c87e",
    version = "a7a3ee9bee1de76fea76ffda8855678a40694e42",
)

load("@android_test_support//:repo.bzl", "android_test_repositories")

android_test_repositories()

# Qt5
# =========================================================

load("//tools/workspace:qt.bzl", "qt_repository")

qt_repository(
    name = "qt",
    version = "5.14.1",
)

# Python
# =========================================================

load("//tools/workspace:python.bzl", "python_repository")

python_repository(
    name = "python3",
)

# Node.js
# =========================================================

#github_archive(
#    name = "rules_codeowners",
#    repo = "zegl/rules_codeowners",
#    #sha256 = "06910242c6d47c5719efd5789cf34dac393034dc0fe4c73f1ed3aac739ffabdc",
#    version = "bdc2f987cd0e15ebfa9b76689a4c9a472730a6f0",
#)
#
#github_archive(
#    name = "build_bazel_rules_nodejs",
#    repo = "bazelbuild/rules_nodejs",
#    sha256 = "171bdbd8386576ed2f6a3f8aff87eeb048f963981870a3a8432be7d12cf5b2cc",
#    version = "1.3.0",
#)
#
#load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")
#
#yarn_install(
#    name = "npm",
#    package_json = "//js-toxcore-c:package.json",
#    yarn_lock = "//js-toxcore-c:yarn.lock",
#)

#load("@npm//:install_bazel_dependencies.bzl", "install_bazel_dependencies")
#install_bazel_dependencies()

#load("@org_pubref_rules_node//node:rules.bzl", "node_repositories", "yarn_modules")
#
#node_repositories()
#
#yarn_modules(
#    name = "yarn_modules",
#    install_tools = [
#        "sh",
#        "dirname",
#    ],
#    deps = {
#        "ansi-to-html": "0.6.4",
#        "async": "2.6.0",
#        "buffertools": "2.1.6",
#        "ffi": "2.2.0",
#        "firebase": "3.9.0",
#        "firepad": "1.4.0",
#        "grunt": "1.0.1",
#        "grunt-jsdoc": "2.2.1",
#        "grunt-shell": "2.1.0",
#        "ink-docstrap": "1.3.2",
#        "jsdoc": "3.5.5",
#        "mktemp": "0.4.0",
#        "mocha": "3.5.3",
#        "ref": "1.3.5",
#        "ref-array": "1.2.0",
#        "ref-struct": "1.1.0",
#        "should": "13.2.1",
#        "underscore": "1.8.3",
#    },
#)
#
#yarn_modules(
#    name = "mocha_modules",
#    deps = {"mocha": "3.5.3"},
#)
