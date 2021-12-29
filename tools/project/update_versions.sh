#!/bin/sh

set -eux

VERSION=$(make -s version)
sed -i \
  -e "s!image: toxchat/toktok-stack:.*-release!image: toxchat/toktok-stack:$VERSION-release!" \
  -e "s!image: toxchat/toktok-stack:.*-debug!image: toxchat/toktok-stack:$VERSION-debug!" \
  ./*/.cirrus.yml \
  tools/project/haskell/cirrus.yml.in

for i in hs-*/.github/workflows/ci.yml; do
  for wf in tools/project/haskell/github/*.yml; do
    cp "$wf" "$(dirname "$i")/$(basename "$wf")"
  done
done

for i in hs-*/; do
  sed -e "s/hs-{PACKAGE}/${i}g" tools/project/haskell/cirrus.yml.in >"$i".cirrus.yml
done
