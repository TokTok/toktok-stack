# Protobuf
# =========================================================

# proto_library rules implicitly depend on @com_google_protobuf//:protoc,
# which is the proto-compiler.
# This statement defines the @com_google_protobuf repo.
http_archive(
    name = "com_google_protobuf",
    sha256 = "0cc6607e2daa675101e9b7398a436f09167dffb8ca0489b0307ff7260498c13c",
    strip_prefix = "protobuf-3.5.0",
    url = "https://github.com/google/protobuf/archive/v3.5.0.tar.gz",
)

# Haskell
# =========================================================

http_archive(
    name = "io_tweag_rules_haskell",
    sha256 = "f473773d19908970e5178bcef0e8a8528d13c1282805300e1ee1f2a7cace1242",
    strip_prefix = "rules_haskell-14e546aff161fcb6ed00a3f5da660d35da921e74",
    urls = ["https://github.com/tweag/rules_haskell/archive/14e546aff161fcb6ed00a3f5da660d35da921e74.tar.gz"],
)

load("@io_tweag_rules_haskell//haskell:repositories.bzl", "haskell_repositories")

haskell_repositories()

register_toolchains("//:ghc")

new_local_repository(
    name = "my_ghc",
    build_file = "third_party/BUILD.ghc",
    path = "/usr",  # Change path accordingly.
)

new_http_archive(
    name = "haskell_QuickCheck",
    build_file = "third_party/haskell/BUILD.QuickCheck",
    sha256 = "488c5652139da0bac8b3e7d76f11320ded298549e62db530938bfee9ca981876",
    strip_prefix = "QuickCheck-2.11.3",
    url = "https://hackage.haskell.org/package/QuickCheck-2.11.3/QuickCheck-2.11.3.tar.gz",
)

new_http_archive(
    name = "haskell_random",
    build_file = "third_party/haskell/BUILD.random",
    sha256 = "b718a41057e25a3a71df693ab0fe2263d492e759679b3c2fea6ea33b171d3a5a",
    strip_prefix = "random-1.1",
    url = "https://hackage.haskell.org/package/random-1.1/random-1.1.tar.gz",
)

new_http_archive(
    name = "haskell_tf_random",
    build_file = "third_party/haskell/BUILD.tf-random",
    sha256 = "2e30cec027b313c9e1794d326635d8fc5f79b6bf6e7580ab4b00186dadc88510",
    strip_prefix = "tf-random-0.5",
    url = "https://hackage.haskell.org/package/tf-random-0.5/tf-random-0.5.tar.gz",
)

new_http_archive(
    name = "haskell_primitive",
    build_file = "third_party/haskell/BUILD.primitive",
    sha256 = "b8e8d70213e22b3fab0e0d11525c02627489618988fdc636052ca0adce282ae1",
    strip_prefix = "primitive-0.6.2.0",
    url = "https://hackage.haskell.org/package/primitive-0.6.2.0/primitive-0.6.2.0.tar.gz",
)

new_http_archive(
    name = "haskell_text",
    build_file = "third_party/haskell/BUILD.text",
    sha256 = "20e0b1627f613b32cc7f2d2e8dcc48a4a61938b24f3d14fb77cee694f0c9311a",
    strip_prefix = "text-1.2.3.0",
    url = "https://hackage.haskell.org/package/text-1.2.3.0/text-1.2.3.0.tar.gz",
)

new_http_archive(
    name = "haskell_hashable",
    build_file = "third_party/haskell/BUILD.hashable",
    sha256 = "94ca8789e13bc05c1582c46b709f3b0f5aeec2092be634b8606dbd9c5915bb7a",
    strip_prefix = "hashable-1.2.6.1",
    url = "https://hackage.haskell.org/package/hashable-1.2.6.1/hashable-1.2.6.1.tar.gz",
)

new_http_archive(
    name = "haskell_unordered_containers",
    build_file = "third_party/haskell/BUILD.unordered-containers",
    sha256 = "a4a188359ff28640359131061953f7dbb8258da8ecf0542db0d23f08bfa6eea8",
    strip_prefix = "unordered-containers-0.2.8.0",
    url = "https://hackage.haskell.org/package/unordered-containers-0.2.8.0/unordered-containers-0.2.8.0.tar.gz",
)

new_http_archive(
    name = "haskell_vector",
    build_file = "third_party/haskell/BUILD.vector",
    sha256 = "b100ee79b9da2651276278cd3e0f08a3c152505cc52982beda507515af173d7b",
    strip_prefix = "vector-0.12.0.1",
    url = "https://hackage.haskell.org/package/vector-0.12.0.1/vector-0.12.0.1.tar.gz",
)

new_http_archive(
    name = "haskell_data_default_class",
    build_file = "third_party/haskell/BUILD.data-default-class",
    sha256 = "4f01b423f000c3e069aaf52a348564a6536797f31498bb85c3db4bd2d0973e56",
    strip_prefix = "data-default-class-0.1.2.0",
    url = "https://hackage.haskell.org/package/data-default-class-0.1.2.0/data-default-class-0.1.2.0.tar.gz",
)

new_http_archive(
    name = "haskell_data_binary_ieee754",
    build_file = "third_party/haskell/BUILD.data-binary-ieee754",
    sha256 = "59975abed8f4caa602f0780c10a9b2493479e6feb71ad189bb10c3ac5678df0a",
    strip_prefix = "data-binary-ieee754-0.4.4",
    url = "https://hackage.haskell.org/package/data-binary-ieee754-0.4.4/data-binary-ieee754-0.4.4.tar.gz",
)

new_http_archive(
    name = "haskell_MissingH",
    build_file = "third_party/haskell/BUILD.MissingH",
    sha256 = "283f2afd46625d98b4e29f77edadfa5e6009a227812ee2ece10091ad6a7e9b71",
    strip_prefix = "MissingH-1.4.0.1",
    url = "https://hackage.haskell.org/package/MissingH-1.4.0.1/MissingH-1.4.0.1.tar.gz",
)

new_http_archive(
    name = "haskell_parsec",
    build_file = "third_party/haskell/BUILD.parsec",
    sha256 = "6f87251cb1d11505e621274dec15972de924a9074f07f7430a18892064c2676e",
    strip_prefix = "parsec-3.1.11",
    url = "https://hackage.haskell.org/package/parsec-3.1.11/parsec-3.1.11.tar.gz",
)

new_http_archive(
    name = "haskell_mtl",
    build_file = "third_party/haskell/BUILD.mtl",
    sha256 = "cae59d79f3a16f8e9f3c9adc1010c7c6cdddc73e8a97ff4305f6439d855c8dc5",
    strip_prefix = "mtl-2.2.1",
    url = "https://hackage.haskell.org/package/mtl-2.2.1/mtl-2.2.1.tar.gz",
)

new_http_archive(
    name = "haskell_hslogger",
    build_file = "third_party/haskell/BUILD.hslogger",
    sha256 = "d7ca6e94a4aacb47a8dc30e3960ab8deff482d2ec9dca9a87b225e03e97e452b",
    strip_prefix = "hslogger-1.2.10",
    url = "https://hackage.haskell.org/package/hslogger-1.2.10/hslogger-1.2.10.tar.gz",
)

new_http_archive(
    name = "haskell_network",
    build_file = "third_party/haskell/BUILD.network",
    sha256 = "776668b0a969d0d57ebabf78943cfc21a1aaf7e5e2ae6288322292125c9440f5",
    strip_prefix = "network-2.6.3.3",
    url = "https://hackage.haskell.org/package/network-2.6.3.3/network-2.6.3.3.tar.gz",
)

# Go
# =========================================================

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "4d8d6244320dd751590f9100cf39fd7a4b75cd901e1f3ffdfd6f048328883695",
    url = "https://github.com/bazelbuild/rules_go/releases/download/0.9.0/rules_go-0.9.0.tar.gz",
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "e3dadf036c769d1f40603b86ae1f0f90d11837116022d9b06e4cd88cae786676",
    url = "https://github.com/bazelbuild/bazel-gazelle/releases/download/0.8/bazel-gazelle-0.8.tar.gz",
)

load("@io_bazel_rules_go//go:def.bzl", "go_rules_dependencies", "go_register_toolchains")
load("@io_bazel_rules_go//go/private:go_repository.bzl", "go_repository")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

go_rules_dependencies()

go_register_toolchains()

gazelle_dependencies()

go_repository(
    name = "com_github_streamrail_concurrent_map",
    commit = "master",
    importpath = "github.com/streamrail/concurrent-map",
)

#go_repository(
#    name = "com_github_petermattis_goid",
#    commit = "master",
#    importpath = "github.com/petermattis/goid",
#)
#
# Workaround for https://github.com/bazelbuild/rules_go/issues/1262.
new_http_archive(
    name = "com_github_petermattis_goid",
    build_file = "third_party/BUILD.com_github_petermattis_goid",
    sha256 = "2c9e36159a9e3061d3b2839e33ff453d238a247483d9eac3917b567cc50b5f1c",
    strip_prefix = "goid-176e84a949d354dcef722e602b312b1a75bacddc",
    url = "https://github.com/petermattis/goid/archive/176e84a949d354dcef722e602b312b1a75bacddc.tar.gz",
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

new_http_archive(
    name = "check",
    build_file = "third_party/BUILD.check",
    sha256 = "464201098bee00e90f5c4bdfa94a5d3ead8d641f9025b560a27755a83b824234",
    strip_prefix = "check-0.12.0",
    url = "https://github.com/libcheck/check/releases/download/0.12.0/check-0.12.0.tar.gz",
)

new_http_archive(
    name = "curl",
    build_file = "third_party/BUILD.curl",
    sha256 = "c92fe31a348eae079121b73884065e600c533493eb50f1f6cee9c48a3f454826",
    strip_prefix = "curl-7.57.0",
    url = "https://github.com/curl/curl/releases/download/curl-7_57_0/curl-7.57.0.tar.bz2",
)

new_http_archive(
    name = "ffmpeg",
    build_file = "third_party/BUILD.ffmpeg",
    sha256 = "f3443e20154a590ab8a9eef7bc951e8731425efc75b44ff4bee31d8a7a574a2c",
    strip_prefix = "ffmpeg-3.4.1",
    url = "http://ffmpeg.org/releases/ffmpeg-3.4.1.tar.bz2",
)

new_http_archive(
    name = "filter_audio",
    build_file = "third_party/BUILD.filter_audio",
    sha256 = "fb135592c5133c3b4b664da18f988f58609db912f204059abe16277df044a366",
    strip_prefix = "filter_audio-0.0.1",
    url = "https://github.com/irungentoo/filter_audio/archive/v0.0.1.tar.gz",
)

new_http_archive(
    name = "gtest",
    build_file = "third_party/BUILD.gtest",
    sha256 = "58a6f4277ca2bc8565222b3bbd58a177609e9c488e8a72649359ba51450db7d8",
    strip_prefix = "googletest-release-1.8.0",
    url = "https://github.com/google/googletest/archive/release-1.8.0.tar.gz",
)

new_http_archive(
    name = "libconfig",
    build_file = "third_party/BUILD.libconfig",
    sha256 = "f67ac44099916ae260a6c9e290a90809e7d782d96cdd462cac656ebc5b685726",
    strip_prefix = "libconfig-1.7.2",
    url = "https://github.com/hyperrealm/libconfig/archive/v1.7.2.tar.gz",
)

new_http_archive(
    name = "libexif",
    build_file = "third_party/BUILD.libexif",
    sha256 = "8cb37aa1745ca9050403c501ad4da2924e98ec5460bbd5c9d09bd57f0c746636",
    strip_prefix = "libexif-libexif-0_6_21-release",
    url = "https://github.com/libexif/libexif/archive/libexif-0_6_21-release.tar.gz",
)

new_http_archive(
    name = "libqrencode",
    build_file = "third_party/BUILD.libqrencode",
    sha256 = "c2c8a8110354463a3332cb48abf8581c8d94136af4dc1418f891cc9c7719e3c1",
    strip_prefix = "libqrencode-4.0.0",
    url = "https://github.com/fukuchi/libqrencode/archive/v4.0.0.tar.gz",
)

new_http_archive(
    name = "libsodium",
    build_file = "third_party/BUILD.libsodium",
    sha256 = "eeadc7e1e1bcef09680fb4837d448fbdf57224978f865ac1c16745868fbd0533",
    strip_prefix = "libsodium-1.0.16",
    url = "https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz",
)

new_http_archive(
    name = "libvpx",
    build_file = "third_party/BUILD.libvpx",
    sha256 = "cda8bb6f0e4848c018177d3a576fa83ed96d762554d7010fe4cfb9d70c22e588",
    strip_prefix = "libvpx-1.6.1",
    url = "https://github.com/webmproject/libvpx/archive/v1.6.1.tar.gz",
)

new_http_archive(
    name = "opus",
    build_file = "third_party/BUILD.opus",
    sha256 = "6d258ffc874070087d15c584c0c491864baad14a55873730d9af35bf72fb1ce1",
    strip_prefix = "opus-1.2.1",
    url = "https://github.com/xiph/opus/archive/v1.2.1.tar.gz",
)

new_http_archive(
    name = "portaudio",
    build_file = "third_party/BUILD.portaudio",
    sha256 = "f5a21d7dcd6ee84397446fa1fa1a0675bb2e8a4a6dceb4305a8404698d8d1513",
    strip_prefix = "portaudio",
    url = "http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz",
)

new_http_archive(
    name = "sndfile",
    build_file = "third_party/BUILD.sndfile",
    sha256 = "1ff33929f042fa333aed1e8923aa628c3ee9e1eb85512686c55092d1e5a9dfa9",
    strip_prefix = "libsndfile-1.0.28",
    url = "http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.28.tar.gz",
)

# Maven dependencies
# =========================================================

maven_jar(
    name = "com_intellij_annotations",
    artifact = "com.intellij:annotations:12.0",
    sha1 = "bbcf6448f6d40abe506e2c83b70a3e8bfd2b4539",
)

maven_jar(
    name = "org_scalatest_scalatest",
    artifact = "org.scalatest:scalatest_2.11:3.0.4",
    sha1 = "a0df09cc87bb681674b05a883462b121866784e5",
)

maven_jar(
    name = "org_scalactic_scalactic",
    artifact = "org.scalactic:scalactic_2.11:3.0.4",
    sha1 = "a97b52d531f6010b424813af260ac6ce748e187e",
)

maven_jar(
    name = "org_scalacheck_scalacheck",
    artifact = "org.scalacheck:scalacheck_2.11:1.13.4",
    sha1 = "7845816647d5a80d30e5a71862b31f3fee894549",
)

maven_jar(
    name = "com_typesafe_scala_logging_scala_logging",
    artifact = "com.typesafe.scala-logging:scala-logging_2.11:3.7.2",
    sha1 = "5015fe84c5aec4f8eb3daa2d1663d447d65f8c02",
)

maven_jar(
    name = "org_slf4j_slf4j_api",
    artifact = "org.slf4j:slf4j-api:1.7.25",
    sha1 = "da76ca59f6a57ee3102f8f9bd9cee742973efa8a",
)

maven_jar(
    name = "com_google_guava_guava",
    artifact = "com.google.guava:guava:19.0",
    sha1 = "6ce200f6b23222af3d8abb6b6459e6c44f4bb0e9",
)

maven_jar(
    name = "com_chuusai_shapeless",
    artifact = "com.chuusai:shapeless_2.11:2.3.3",
    sha1 = "ea34d4b6128b9090386945dcb952816bd9e87ce2",
)

maven_jar(
    name = "org_apache_commons_commons_lang3",
    artifact = "org.apache.commons:commons-lang3:3.4",
    sha1 = "5fe28b9518e58819180a43a850fbc0dd24b7c050",
)

maven_jar(
    name = "junit_junit",
    artifact = "junit:junit:4.12",
    sha1 = "2973d150c0dc1fefe998f834810d68f278ea58ec",
)

maven_jar(
    name = "org_slf4j_slf4j_log4j12",
    artifact = "org.slf4j:slf4j-log4j12:1.7.22",
    sha1 = "3bb94b26c2ad2f8755302aa9bf96f03b23a76639",
)

maven_jar(
    name = "log4j_log4j",
    artifact = "log4j:log4j:1.2.17",
    sha1 = "5af35056b4d257e4b64b9e8069c0746e8b08629f",
)

maven_jar(
    name = "org_bytedeco_javacpp",
    artifact = "org.bytedeco:javacpp:1.4",
    sha1 = "6e9062d70f863a4e55b3827d42d302f94e89d7e5",
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
    name = "org_bytedeco_javacpp_presets_opencv",
    artifact = "org.bytedeco.javacpp-presets:opencv:3.4.0-1.4",
    sha1 = "b82eeed2295f30369044b2520937d764efeb3e1e",
)

local_repository(
    name = "org_bytedeco_javacpp_presets_opencv_linux_x86_64",
    path = "third_party/javacpp/opencv",
)

maven_jar(
    name = "org_bytedeco_javacpp_presets_ffmpeg",
    artifact = "org.bytedeco.javacpp-presets:ffmpeg:3.4.1-1.4",
    sha1 = "bf46f2d74014475c948f1a8e063fae50ab724520",
)

local_repository(
    name = "org_bytedeco_javacpp_presets_ffmpeg_linux_x86_64",
    path = "third_party/javacpp/ffmpeg",
)

# Scala toolchain
# =========================================================

rules_scala_version = "0b41f545afaf3efd1af80c1188cecd124b8225e1"

http_archive(
    name = "io_bazel_rules_scala",
    sha256 = "7114abe270d5cb20c1ebb97856ab00a08aef5dbc35135c6412f00f2f6cf87288",
    strip_prefix = "rules_scala-%s" % rules_scala_version,
    type = "zip",
    url = "https://github.com/bazelbuild/rules_scala/archive/%s.zip" % rules_scala_version,
)

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")

scala_register_toolchains()

scala_repositories()

scala_proto_repositories()

# Qt5
# =========================================================

new_local_repository(
    name = "qt",
    build_file = "third_party/BUILD.qt",
    path = "/opt/qt59",
)
