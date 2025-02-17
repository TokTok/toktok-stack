#!/bin/sh

set -eux

BUILDTOOLS_VERSION="v7.3.1"

mkdir -p "$HOME/.bin"
export PATH="$PATH:$HOME/.bin"

for prog in buildifier buildozer unused_deps; do
  curl -L -s -o "$prog" "https://github.com/bazelbuild/buildtools/releases/download/$BUILDTOOLS_VERSION/$prog-linux-amd64"
  sudo install -o root -g root -m 755 "$prog" "$HOME/.bin/$prog"
  rm -f "$prog"
done
