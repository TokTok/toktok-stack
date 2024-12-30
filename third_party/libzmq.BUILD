load("@rules_cc//cc:defs.bzl", "cc_library")

genrule(
    name = "regen_config",
    srcs = glob(["**"]),
    outs = ["platform.hpp"],
    cmd = """
        BASE=`pwd`
        mkdir `dirname $(location CMakeLists.txt)`/_build
        cd `dirname $(location CMakeLists.txt)`/_build
        "$$BASE/$(location @cmake)" .. -DCMAKE_MAKE_PROGRAM="$$BASE/$(location @gnumake)" -DCMAKE_C_COMPILER=$$BASE/$(CC) -DPOLLER=select
        DIR=`pwd`
        cd -
        for i in $(OUTS); do
          cp "$$DIR"/`echo $$i | sed -e 's|$(GENDIR)/external/libzmq/||'` $$i
        done
    """,
    toolchains = ["@rules_cc//cc:current_cc_toolchain"],
    tools = [
        "@cmake",
        "@gnumake",
    ],
)

cc_library(
    name = "libzmq",
    srcs = glob(
        [
            "src/*.cpp",
            "src/*.h",
            "src/*.hpp",
        ],
        exclude = [
            "test/*",
            "src/ws_*.cpp",
            "src/wss_*.cpp",
        ],
    ),
    hdrs = [
        "include/zmq.h",
        "include/zmq_utils.h",
    ],
    copts = [
        "-Ithird_party/libzmq/freebsd",
        "-Ithird_party/libzmq/linux",
        "-Ithird_party/libzmq/osx",
        "-Ithird_party/libzmq/windows",
        "-fexceptions",  # Needed to catch std::bad_alloc.
    ],
    defines = ["ZMQ_STATIC"],
    includes = ["include"],
    visibility = ["//visibility:public"],
    deps = [
        "@libsodium",
        "@pthread",
        "@toktok//third_party/libzmq:platform",
    ],
)
