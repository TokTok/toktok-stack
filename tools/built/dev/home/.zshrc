#!/usr/bin/zsh

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="cypher"

CASE_SENSITIVE=true
COMPLETION_WAITING_DOTS=true
HYPHEN_INSENSITIVE=true

HISTFILE=$HOME/.local/share/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000

plugins=(bazel git)

source $ZSH/oh-my-zsh.sh

# User configuration

#export PATH="$PATH:/src/workspace/bazel-workspace/external/rules_haskell_ghc_linux_amd64/bin"
export PATH="$PATH:/src/workspace/hs-github-tools/tools"
export PATH="$PATH:$HOME/flutter/bin"

alias gs=gst
alias gsr="git ss"
alias ls="ls -Fv --color=tty --group-directories-first --quoting-style=shell"

cd /src/workspace
