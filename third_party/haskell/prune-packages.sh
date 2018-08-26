#!/bin/sh

# Removes all packages from packages.bzl that don't have a corresponding BUILD
# file in //third_party/haskell.

for pkg in $(grep ": struct" third_party/haskell/packages.bzl | grep -o '".*"' | grep -o '[^"]*'); do
  if ! test -f third_party/haskell/BUILD.$pkg; then
    sed -i -e "/\"$pkg\": struct/,/),/d" third_party/haskell/packages.bzl
  fi
done
