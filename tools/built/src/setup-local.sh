#!/bin/sh

set -eux

git clone --depth=1 https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
vi --not-a-term +PluginInstall +qall
cat ~/.vim/settings.vim >>~/.vimrc

if grep "BEGIN" ~/key.pem; then
  gpg --import ~/key.pem
fi
