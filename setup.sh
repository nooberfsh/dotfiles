#!/usr/bin/bash

set -e

# get absolute dir of the root
SCRIPT=$(readlink -f "$0")
ROOT=$(dirname "$SCRIPT")
echo "root dir: $ROOT"


gitconfig="$HOME/.gitconfig"
if [ -f $gitconfig ]; then
   echo "$gitconfig exists, skip"
else
   echo "$gitconfig does not exist, create symlink..."
   ln -s "$ROOT/config/.gitconfig" $gitconfig
fi

neovim="$HOME/.config/nvim/init.vim"
if [ -f $neovim ]; then
   echo "$neovim exists, skip"
else
   echo "$neovim does not exist, create symlink..."
   mkdir -p $(dirname "$neovim")
   ln -s "$ROOT/config/init.vim" $neovim
fi

tmux="$HOME/.tmux.conf"
if [ -f $tmux ]; then
   echo "$tmux exists, skip"
else
   echo "$tmux does not exist, create symlink..."
   ln -s "$ROOT/config/.tmux.conf" $tmux
fi

ideavimrc="$HOME/.ideavimrc"
if [ -f $ideavimrc ]; then
   echo "$ideavimrc exists, skip"
else
   echo "$ideavimrc does not exist, create symlink..."
   ln -s "$ROOT/config/.ideavimrc" $ideavimrc
fi
