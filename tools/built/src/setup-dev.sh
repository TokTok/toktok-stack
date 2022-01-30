#!/bin/sh

set -eux

for prog in buildifier buildozer unused_deps; do
  wget -q -O "$prog" "https://github.com/bazelbuild/buildtools/releases/download/4.2.5/$prog-linux-amd64"
  sudo install -o root -g root -m 755 "$prog" "/usr/local/bin/$prog"
done

echo "export BAZEL_COMPDB_BAZEL_PATH=bazel-nomodules" >>~/.zlogin
echo "export CC=$CC" >>~/.zlogin
echo "export CXX=$CXX" >>~/.zlogin

INSTALL_DIR="/usr/local/bin"
VERSION="0.5.2"

# Download and symlink.
(
  cd "$INSTALL_DIR" &&
    curl -L "https://github.com/grailbio/bazel-compilation-database/archive/$VERSION.tar.gz" | sudo tar -xz &&
    sudo ln -f -s "$INSTALL_DIR/bazel-compilation-database-$VERSION/generate.py" bazel-compdb
)

bazel-compdb
bazel build --show_timestamps //...
tools/retry 5 bazel test --show_timestamps -- //... -//jvm-toxcore-c:ToxCryptoImplTest
