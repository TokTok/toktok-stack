# We enable color always, starting from the first aquery. This isn't strictly
# required, but otherwise we'd put it in the command line arguments anyway.
build --color=yes

# Flags that control how the workspace is laid out. These must be shared with
# the initial aquery in the Docker build, otherwise the second aquery will
# reinitialise the entire workspace.
build --experimental_disable_external_package
build --experimental_repository_cache_hardlinks

# Java toolchain.
build:rbe --extra_toolchains=@bazel_toolchain//toolchain/java:all

# C/C++ toolchain.
build:rbe --extra_toolchains=@bazel_toolchain//toolchain/config:cc-toolchain
build:rbe --crosstool_top=@bazel_toolchain//toolchain/cc:toolchain

# Platform flags:
# The toolchain container used for execution is defined in the target indicated
# by "extra_execution_platforms", "host_platform" and "platforms".
# More about platforms: https://docs.bazel.build/versions/master/platforms.html
build:rbe --extra_execution_platforms=@bazel_toolchain//toolchain/config:platform
build:rbe --host_platform=@bazel_toolchain//toolchain/config:platform
build:rbe --platforms=@bazel_toolchain//toolchain/config:platform

# Docker image build toxchat/toktok-stack running clang-14 in the
# toxchat/builder image.
build:docker --config=rbe
