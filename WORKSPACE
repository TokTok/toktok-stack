# C/C++ dependencies
# ======================================================================

new_http_archive(
    name = "check",
    build_file = "third_party/BUILD.check",
    sha256 = "464201098bee00e90f5c4bdfa94a5d3ead8d641f9025b560a27755a83b824234",
    strip_prefix = "check-0.12.0",
    url = "https://github.com/libcheck/check/releases/download/0.12.0/check-0.12.0.tar.gz",
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

# Maven dependencies
# ======================================================================

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

# Scala toolchain
# ======================================================================

rules_scala_version = "0b41f545afaf3efd1af80c1188cecd124b8225e1"

http_archive(
    name = "io_bazel_rules_scala",
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

# Protobuf
# ======================================================================

# proto_library rules implicitly depend on @com_google_protobuf//:protoc,
# which is the proto-compiler.
# This statement defines the @com_google_protobuf repo.
http_archive(
    name = "com_google_protobuf",
    sha256 = "0cc6607e2daa675101e9b7398a436f09167dffb8ca0489b0307ff7260498c13c",
    strip_prefix = "protobuf-3.5.0",
    url = "https://github.com/google/protobuf/archive/v3.5.0.tar.gz",
)

# Qt5
# ======================================================================

new_local_repository(
    name = "qt",
    build_file = "third_party/BUILD.qt",
    path = "/usr/include/x86_64-linux-gnu/qt5",
)
