workspace(name = "toktok")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//tools/workspace:github.bzl", "github_archive", "new_github_archive")

new_local_repository(
    name = "bazel_toolchain",
    build_file = "third_party/BUILD.bazel_toolchain",
    path = "/src/toolchain",
)

github_archive(
    name = "rules_cc",
    repo = "bazelbuild/rules_cc",
    sha256 = "fe1e7b1801a63e79eb1b40dc44bf0590117a399e118ac44afd6fa07bf63e9ece",
    version = "58f8e026c00a8a20767e3dc669f46ba23bc93bdb",
)

github_archive(
    name = "rules_java",
    repo = "bazelbuild/rules_java",
    sha256 = "74d05fcd95df837a72cf2335b05586bbd77bd7f6725858a9fb262ef81f5a93e9",
    version = "7a98cf2adcae6a0e2eae0d392f92ea19159fbef1",
)

github_archive(
    name = "rules_proto",
    repo = "bazelbuild/rules_proto",
    sha256 = "ec3692776b2973954e22ed3b6ed346e3c43e67269eacc8cd43c7fc6aa47b710a",
    version = "0bc8db13f8dc8f5d435be07e276712db1ca11a91",
)

github_archive(
    name = "rules_python",
    repo = "bazelbuild/rules_python",
    sha256 = "18a8d97f706d768169f93e251d02eea6f8e1810bd90c2fe78cfdf036aa1772ef",
    version = "fe30f1561e3afef59e3f8be6339c88444100de25",
)

github_archive(
    name = "bazel_skylib",
    repo = "bazelbuild/bazel-skylib",
    sha256 = "8d514db81bfba3d9eb2f77b4143118a8920d2c4987d3d0810e69177c00934b6e",
    version = "8334f938c1574ef6f1f7a38a03550a31df65274e",
)

# Fuzzing
# =========================================================

http_archive(
    name = "rules_fuzzing",
    sha256 = "23bb074064c6f488d12044934ab1b0631e8e6898d5cf2f6bde087adb01111573",
    strip_prefix = "rules_fuzzing-0.3.1",
    urls = ["https://github.com/bazelbuild/rules_fuzzing/archive/v0.3.1.zip"],
)

load("@rules_fuzzing//fuzzing:init.bzl", "rules_fuzzing_init")
load("@rules_fuzzing//fuzzing:repositories.bzl", "rules_fuzzing_dependencies")

rules_fuzzing_dependencies()

rules_fuzzing_init()

# Protobuf
# =========================================================

# proto_library rules implicitly depend on @com_google_protobuf//:protoc,
# which is the proto-compiler.
# This statement defines the @com_google_protobuf repo.
github_archive(
    name = "com_google_protobuf",
    repo = "protocolbuffers/protobuf",
    sha256 = "25680843adf0c3302648d35f744e38cc3b6b05a6c77a927de5aea3e1c2e36106",
    version = "v3.19.4",
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

# Rust
# =========================================================

github_archive(
    name = "rules_rust",
    repo = "bazelbuild/rules_rust",
    sha256 = "3b0f5c479c66f7854cc25d72227599647643af7c09141d4a301d2077fefa6649",
    version = "9d70a5ac013561d04e3ded34f383aea22842cbeb",
)

load("@rules_rust//rust:repositories.bzl", "rust_repositories")

rust_repositories()

# Haskell
# =========================================================

github_archive(
    name = "rules_sh",
    repo = "tweag/rules_sh",
    sha256 = "b6efbe69769514ea5d6f9b79352fbc286fe0939e7fc13b4db24b0aa329b7735b",
    version = "v0.2.0",
)

github_archive(
    name = "rules_haskell",
    repo = "tweag/rules_haskell",
    sha256 = "1d60168daff6d0225b9c231b3622c31b91a7b37e2487bed1cde5b5990a5c3f29",
    version = "26494b7bdcd7bd02463d6d6ebe32b7c00c607024",
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
        "-optc=-Wno-unused-command-line-argument",
        "-fdiagnostics-color=always",
    ],
    version = "8.10.7",
)

github_archive(
    name = "ai_formation_hazel",
    repo = "FormationAI/hazel",
    sha256 = "db5466c442c228cffab14c51daff46a7861fdea3ef62be3e80ccd4b8dc60ab3e",
    version = "fe4b139751951f9489434f3f26e96598a1afebe1",
)

load("@ai_formation_hazel//tools:mangling.bzl", "hazel_workspace")
load("//third_party/haskell:haskell.bzl", "new_cabal_package")
load("//third_party/haskell:packages.bzl", "core_packages", "packages")

[new_local_repository(
    name = hazel_workspace(pkg),
    build_file = "third_party/haskell/BUILD.bazel",
    path = "third_party/haskell",
) for pkg in core_packages]

[new_cabal_package(
    package = "%s-%s" % (
        pkg,
        data.version,
    ),
    patches = data.patches,
    path = data.path,
    sha256 = data.sha256,
) for pkg, data in packages.items()]

# Go
# =========================================================

github_archive(
    name = "io_bazel_rules_go",
    repo = "bazelbuild/rules_go",
    sha256 = "57bfd6a77a5be1fd9bce07d00afdfac232c06f303c1650053a794ab77ef1278f",
    version = "v0.31.0",
)

github_archive(
    name = "bazel_gazelle",
    repo = "bazelbuild/bazel-gazelle",
    sha256 = "b5b1bf61e25709be1badcbc574fce36aa3376120f9b84a3cdb30c963e5b7629b",
    version = "v0.24.0",
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies", "go_repository")
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.17")

gazelle_dependencies()

go_repository(
    name = "com_github_things_go_go_socks5",
    commit = "master",
    importpath = "github.com/things-go/go-socks5",
)

go_repository(
    name = "com_github_gorilla_websocket",
    commit = "master",
    importpath = "github.com/gorilla/websocket",
)

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

http_archive(
    name = "ncurses",
    build_file = "@toktok//third_party:BUILD.ncurses",
    sha256 = "97fc51ac2b085d4cde31ef4d2c3122c21abc217e9090a43a30fc5ec21684e059",
    strip_prefix = "ncurses-6.3",
    urls = ["https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.3.tar.gz"],
)

local_library_repository(
    name = "x264",
    version = "r2917_1",
)

github_archive(
    name = "boringssl",
    repo = "google/boringssl",
    sha256 = "0842dd6dabeb4a039241148c3207eaa0306fd016714dbce7b8b50524e3389f2b",
    version = "d7f01bfd845f17b6b6f8c7a754b9bb28bc6dc12d",
)

local_library_repository(
    name = "openssl",
    brew_name = "openssl@1.1",
    libs = [
        "crypto",
        "ssl",
    ],
    version = "1.1.1g",
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
    sha256 = "420e5b0af464ae648e19f14a10af817f3a998fac52974676c842db10ded28666",
    version = "0affd45b62371c1de44064a5a5f8817242208442",
)

new_github_archive(
    name = "curl",
    repo = "curl/curl",
    sha256 = "c3181fd2ec477a55f359b4c89eb13de984200ee59fd493d84a4a53e5d7dd4a9f",
    version = "curl-7_70_0",
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
    sha256 = "8fc9f20ac5ed95115a9e285647add0eedd5cc1a98a039ada14c132452f98ac42",
    strip_prefix = "ffmpeg-4.4.1",
    urls = ["https://ffmpeg.org/releases/ffmpeg-4.4.1.tar.bz2"],
)

#new_local_repository(
#    name = "ffmpeg",
#    build_file = "@toktok//third_party:BUILD.ffmpeg",
#    path = "third_party/ffmpeg/ffmpeg-4.2.2",
#)

http_archive(
    name = "gettext",
    build_file = "@toktok//third_party:BUILD.gettext",
    sha256 = "66415634c6e8c3fa8b71362879ec7575e27da43da562c798a8a2f223e6e47f5c",
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
    sha256 = "a1f3a0d2549b535807f711b223cecc1d65d24c322f25a35d9c7cb98acb0e217d",
    version = "13f984c2162d8392d3fd0ffb8666ee518f60665a",
)

new_github_archive(
    name = "libzmq",
    repo = "zeromq/libzmq",
    sha256 = "710cbbbd97cd8ab6831466d8d4f2e9f491efacf34c24c72183c4e6428e203300",
    version = "v4.3.2",
)

new_github_archive(
    name = "msgpack-c",
    patches = ["@toktok//third_party/patches:msgpack-c.patch"],
    repo = "msgpack/msgpack-c",
    sha256 = "fa6648361c9254ae7897be2b0731570dcae047d2f07f0b732f443ac7d11c37ec",
    version = "c-4.0.0",
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
    patches = ["@toktok//third_party/patches:sqlcipher.patch"],
    repo = "sqlcipher/sqlcipher",
    sha256 = "41e1408465488e9c478ca5b7c5f8410405a10caa73b82db60ac115a76c563c05",
    version = "v4.3.0",
)

new_github_archive(
    name = "tcl",
    repo = "tcltk/tcl",
    sha256 = "f58abc084565e658a611765891c9c89db12137197a389b259998abef22bfff3f",
    version = "95b7301fac733f972e6e837f4e27c42c5487e6ec",
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

# JUnit5
# =========================================================

load("//tools/workspace:junit5.bzl", "junit_jupiter_java_repositories", "junit_platform_java_repositories")

junit_jupiter_java_repositories()

junit_platform_java_repositories()

# Maven dependencies
# =========================================================

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
        "com.chuusai:shapeless_2.11:2.3.3",
        "com.google.guava:guava:19.0",
        "com.typesafe.scala-logging:scala-logging_2.11:3.7.2",
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
        "org.scalatestplus:scalacheck-1-14_2.11:3.1.0.1",
        "org.scalatestplus:junit-4-13_2.11:3.2.10.0",
        "org.scala-lang.modules:scala-swing_2.11:2.1.1",
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
    sha256 = "5456e8d90f6a45b698f26f2aee5f86e4380c0afc14cbcd0994b8e69857c0c525",
    version = "72adeb585081c4cf53d033d554dbdddbb1e59fbc",
)

load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")

scala_config(scala_version = "2.11.12")

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")
load("@io_bazel_rules_scala//scala_proto:toolchains.bzl", "scala_proto_register_enable_all_options_toolchain")
load("@io_bazel_rules_scala//testing:scalatest.bzl", "scalatest_repositories", "scalatest_toolchain")

scala_register_toolchains()

scala_repositories()

scala_proto_repositories()

scala_proto_register_enable_all_options_toolchain()

scalatest_repositories()

scalatest_toolchain()

# Qt5
# =========================================================

load("//tools/workspace:qt.bzl", "qt_repository")

qt_repository(
    name = "qt",
    version = "5.14.2",
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
    sha256 = "cff4d1667bf1d6d3e60b093a78c515cc76d6c13a93520252a4a412db15d6db8a",
    version = "3.0.0a10",
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

# Compilation database
# =========================================================

# Tool used for creating a compilation database.
github_archive(
    name = "io_kythe",
    repo = "kythe/kythe",
    sha256 = "804da114170d0403a2a5fee88ed0dc3109be8e43681bee6cea5223f875979ebb",
    version = "3842dabd95eb2adf4852d5ad04fb2bc6279e9e70",
)

http_archive(
    name = "com_github_tencent_rapidjson",
    build_file = "@io_kythe//third_party:rapidjson.BUILD",
    sha256 = "e6fc99c7df7f29995838a764dd68df87b71db360f7727ace467b21b82c85efda",
    strip_prefix = "rapidjson-8f4c021fa2f1e001d2376095928fc0532adf2ae6",
    url = "https://github.com/Tencent/rapidjson/archive/8f4c021fa2f1e001d2376095928fc0532adf2ae6.zip",
)

new_github_archive(
    name = "com_github_google_glog",
    build_file_content = "\n".join([
        "load(\"//:bazel/glog.bzl\", \"glog_library\")",
        "glog_library(with_gflags=0)",
    ]),
    repo = "google/glog",
    sha256 = "feca3c7e29a693cab7887409756d89d342d4a992d54d7c5599bebeae8f7b50be",
    version = "3ba8976592274bc1f907c402ce22558011d6fc5e",
)

load("@io_kythe//:setup.bzl", "kythe_rule_repositories")

kythe_rule_repositories()
