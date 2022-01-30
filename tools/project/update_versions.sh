#!/bin/sh

set -eux

for i in hs-*/.github/workflows/ci.yml; do
  for wf in tools/project/haskell/github/*.yml; do
    cp "$wf" "$(dirname "$i")/$(basename "$wf")"
  done
done

for i in hs-*/; do
  sed -e "s/hs-{PACKAGE}/${i}g" tools/project/haskell/cirrus.yml.in >"$i".cirrus.yml
done
