#!/bin/sh

# This is intended to be used inside a dev's local directory.
#
# You should create a "home" directory with some configs in it as you like
# them. In particular, you will need a Vundle-enabled VIM or NeoVIM config.

set -eux

if [ ! -d workspace ]; then
  git clone https://github.com/TokTok/toktok-stack workspace
fi

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

docker build -t iphydf/toktok-dev -f workspace/tools/built/Dockerfile .
# If a docker-toktok service is running, stop it now. If it doesn't exist,
# we don't care.
sudo systemctl stop docker-toktok || true
docker run --name=toktok-dev --rm -it \
  -p 2223:22 \
  -v "$PWD"/workspace:/src/workspace \
  -v "$HOME"/.local/share/zsh/toktok:/home/builder/.local/share/zsh \
  iphydf/toktok-dev
