#!/bin/sh

set -eux

BUILDTOOLS_VERSION="v10.2.0"

mkdir -p "$HOME/.bin"
export PATH="$PATH:$HOME/.bin"

for prog in buildifier buildozer unused-deps; do
  curl -f -L -s -o "$prog" "https://github.com/bazelbuild/buildtools/releases/download/$BUILDTOOLS_VERSION/$prog-linux-amd64"
  sudo install -o root -g root -m 755 "$prog" "$HOME/.bin/$prog"
  rm -f "$prog"
done
