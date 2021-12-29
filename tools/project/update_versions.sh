#!/bin/sh

set -eux

VERSION=$(make -s version)
sed -i \
  -e "s!image: toxchat/toktok-stack:.*-release!image: toxchat/toktok-stack:$VERSION-release!" \
  -e "s!image: toxchat/toktok-stack:.*-debug!image: toxchat/toktok-stack:$VERSION-debug!" \
  ./*/.cirrus.yml \
  tools/project/haskell_cirrus.yml.in

for i in hs-*/.github/workflows/ci.yml; do
  cp tools/project/haskell_ci.yml.in "$i"
done
