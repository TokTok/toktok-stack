#!/bin/sh

set -eux

BUILDTOOLS_VERSION="v6.3.3"
BCDB_VERSION="0.5.2"

for prog in buildifier buildozer unused_deps; do
  wget -q -O "$prog" "https://github.com/bazelbuild/buildtools/releases/download/$BUILDTOOLS_VERSION/$prog-linux-amd64"
  sudo install -o root -g root -m 755 "$prog" "/usr/local/bin/$prog"
done

sudo install -o root -g root -m 755 tools/built/src/bazel-nomodules /usr/local/bin/bazel-nomodules

echo "export BAZEL_COMPDB_BAZEL_PATH=$BAZEL_COMPDB_BAZEL_PATH" >>~/.zlogin

INSTALL_DIR="/usr/local/bin"

# Download and symlink.
(
  cd "$INSTALL_DIR" &&
    curl -L "https://github.com/grailbio/bazel-compilation-database/archive/$BCDB_VERSION.tar.gz" | sudo tar -xz &&
    sudo ln -f -s "$INSTALL_DIR/bazel-compilation-database-$BCDB_VERSION/generate.py" bazel-compdb
)

# There are tests that check whether this script was ran. We don't care about
# that in the toktok-stack builds. It's checked in the submodule builds.
tools/project/update_versions.sh

bazel-compdb
bazel build --show_timestamps //...
# tools/retry 5 bazel test --show_timestamps -- //...
