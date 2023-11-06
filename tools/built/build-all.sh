#!/bin/sh

set -eux

# Build the entire set of docker images for the toktok dev container.
(cd dockerfiles/buildfarm/bazel && ./build.sh)
docker build -t toxchat/toktok-stack:latest-third_party -f tools/built/src/Dockerfile.third_party .
docker build -t toxchat/toktok-stack:latest -f tools/built/src/Dockerfile .
docker build -t toxchat/toktok-stack:latest-fastbuild -f tools/built/src/Dockerfile.fastbuild .
docker build -t toxchat/toktok-stack:latest-dev -f tools/built/src/Dockerfile.dev .
