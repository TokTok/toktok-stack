#!/bin/sh

set -eux

git clone --depth=1 https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
vi --not-a-term +PluginInstall +qall
cat ~/.vim/settings.vim >> ~/.vimrc

bazel-compdb
bazel build --show_timestamps //...
