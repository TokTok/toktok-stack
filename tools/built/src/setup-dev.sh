#!/bin/sh

set -eux

BUILDTOOLS_VERSION="v6.3.3"
BCDB_VERSION="0.5.2"

mkdir -p "$HOME/.bin"
export PATH="$PATH:$HOME/.bin"

for prog in buildifier buildozer unused_deps; do
  curl -L -s -o "$prog" "https://github.com/bazelbuild/buildtools/releases/download/$BUILDTOOLS_VERSION/$prog-linux-amd64"
  sudo install -o root -g root -m 755 "$prog" "$HOME/.bin/$prog"
  rm -f "$prog"
done

sudo install -o root -g root -m 755 tools/built/src/bazel-nomodules "$HOME/.bin/bazel-nomodules"

echo "export BAZEL_COMPDB_BAZEL_PATH=$BAZEL_COMPDB_BAZEL_PATH" >>~/.zlogin

INSTALL_DIR="$HOME/.bin"

# Download and symlink.
(
  cd "$INSTALL_DIR" &&
    curl -L "https://github.com/grailbio/bazel-compilation-database/archive/$BCDB_VERSION.tar.gz" | sudo tar -xz &&
    sudo ln -f -s "$INSTALL_DIR/bazel-compilation-database-$BCDB_VERSION/generate.py" bazel-compdb
)

# There are tests that check whether this script was ran. We don't care about
# that in the toktok-stack builds. It's checked in the submodule builds.
tools/project/update_versions.sh

# Start nix-daemon if it isn't running yet.
if ! (ps aux | grep nix-daemon | grep -v grep); then
  sudo nix-daemon --daemon &
  sleep 1
fi

# Generate compile_commands.json, used by YCM and vscode.
nix-shell -p python3 --run "python3 $HOME/.bin/bazel-compdb"

# Run all tests to completion, so the dev container starts out with all tests
# passing (so any potential breakage is local only).
# FIXME
#tools/retry 5 bazel test --show_timestamps -- //...
