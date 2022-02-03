#!/bin/sh

set -eux

IMAGE="$1"
shift

if [ "$@" = "-u" ]; then
  docker pull toxchat/toktok-stack:latest-dev
fi
docker build -t "$IMAGE" -f workspace/tools/built/dev/Dockerfile home
sudo systemctl restart docker-toktok
sudo journalctl -f -u docker-toktok
