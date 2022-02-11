#!/bin/sh

set -eux

for i in hs-*/.github/workflows/ci.yml; do
  for wf in tools/project/haskell/github/*.yml; do
    cp "$wf" "$(dirname "$i")/$(basename "$wf")"
  done
done

for i in hs-*/; do
  mkdir -p "$i".github/docker
  PKG=$(echo "$i" | sed -e 's|^hs-||;s|/||')
  if ! grep custom_cirrus "$i"BUILD.bazel; then
    sed -e "s/{PACKAGE}/$PKG/g" tools/project/haskell/cirrus.yml.in >"$i".cirrus.yml
  fi
  sed -e "s/{PACKAGE}/$PKG/g" tools/project/haskell/github/Dockerfile >"$i".github/docker/Dockerfile
done
