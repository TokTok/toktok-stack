#!/bin/sh

set -eux

VERSION=$(make version)
sed -i \
  -e "s!image: toxchat/toktok-stack:.*!image: toxchat/toktok-stack:$VERSION!" \
  */.cirrus.yml \
  tools/project/haskell_cirrus.yml.in

for i in hs-*/.github/workflows/ci.yml; do
  cp tools/project/haskell_ci.yml.in "$i"
done
