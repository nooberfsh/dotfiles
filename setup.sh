#!/usr/bin/bash

set -e

# get absolute dir of the root
SCRIPT=$(readlink -f "$0")
ROOT=$(dirname "$SCRIPT")
echo "root dir: $ROOT"

# $1: 文件名，不带path
# $2: symlink创建的目录，默认为$HOME
create_symlink(){
    p="$HOME/$1"
    if [ ! -z "$2" ]; then
	p="$2/$1"
	mkdir -p $2
    fi
    if [ -f $p ]; then
   	echo "$p exists, skip"
    else
       echo "$p does not exist, create symlink..."
       ln -s "$ROOT/config/$1" $p
    fi
}

gitconfig=".gitconfig"
create_symlink $gitconfig 

neovim="init.vim"
neovim_dir="$HOME/.config/nvim"
create_symlink $neovim $neovim_dir

tmux=".tmux.conf"
create_symlink $tmux 

ideavimrc=".ideavimrc"
create_symlink $ideavimrc
