#!/bin/bash

set -e

# get absolute dir of the root
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
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

profile=".profile"
create_symlink $profile

xprofile=".xprofile"
create_symlink $xprofile

zshrc=".zshrc"
create_symlink $zshrc