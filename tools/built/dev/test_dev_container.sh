#!/bin/sh

# This is intended to be used inside a dev's local directory.
#
# You should create a "home" directory with some configs in it as you like
# them. In particular, you will need a Vundle-enabled VIM or NeoVIM config.
#
# This assumes "toktok-stack" is cloned into the "workspace" subdirectory.

set -eux

IMAGE="$1"

if [ ! -f home/.ssh/authorized_keys ]; then
  mkdir -f home/.ssh
  cp ~/.ssh/id_rsa.pub home/.ssh/authorized_keys
fi

if [ ! -f home/.ssh/id_rsa ]; then
  ssh-keygen -f home/.ssh/id_rsa
fi

(cd workspace && docker build -t toxchat/toktok-stack:latest-dev -f tools/built/src/Dockerfile.dev .)
tar c home workspace/tools/built/dev |
  docker build -t "$IMAGE" -f workspace/tools/built/dev/Dockerfile -
docker run --name=toktok-dev --rm -it \
  -p 2224:22 \
  --tmpfs "/run" \
  --tmpfs "/run/wrappers:exec,suid" \
  --tmpfs "/tmp" \
  -v "/sys/fs/cgroup:/sys/fs/cgroup" \
  -v "$PWD/workspace:/src/workspace" \
  -v "$HOME/.local/share/vscode/config:/src/workspace/.vscode" \
  -v "$HOME/.local/share/vscode/server:/home/builder/.vscode-server" \
  -v "$HOME/.local/share/zsh/toktok:/home/builder/.local/share/zsh" \
  "$IMAGE"
