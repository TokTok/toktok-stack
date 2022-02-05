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

if [ ! -f home/.vimrc -a ! -f home/.config/nvim/init.vim ]; then
  echo "vim config doesn't exist in home directory - vundle installation will fail"
  exit 1
fi

tar c home workspace/tools/built/dev | \
  docker build -t "$IMAGE" -f workspace/tools/built/dev/Dockerfile -
docker run --name=toktok-dev --rm -it \
  -p 2224:22 \
  -v "$PWD/workspace:/src/workspace" \
  -v "$HOME/.local/share/vscode/config:/src/workspace/.vscode" \
  -v "$HOME/.local/share/vscode/server:/home/builder/.vscode-server" \
  -v "$HOME/.local/share/zsh/toktok:/home/builder/.local/share/zsh" \
  "$IMAGE"
