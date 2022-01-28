#!/bin/bash

set -eux

wget -O /tmp/rbe_configs_gen https://github.com/bazelbuild/bazel-toolchains/releases/download/v5.1.1/rbe_configs_gen_linux_amd64
chmod +x /tmp/rbe_configs_gen

# This uses toxchat/bazel instead of toxchat/builder so it can see all the
# installed headers for the various out-of-tree system dependencies.
/tmp/rbe_configs_gen \
  --bazel_version="$(cat .bazelversion)" \
  --toolchain_container=toxchat/bazel:latest \
  --output_src_root="$PWD" \
  --output_config_path=toolchain \
  --exec_os=linux \
  --target_os=linux

rm -f /tmp/rbe_configs_gen
