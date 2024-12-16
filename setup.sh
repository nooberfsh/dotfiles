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


#####################################################
tmux="tmux.conf"
tmux_dir="$HOME/.config/tmux"
create_symlink $tmux $tmux_dir

ideavimrc="ideavimrc"
ideavim_dir="$HOME/.config/ideavim"
create_symlink $ideavimrc $ideavim_dir

fish="config.fish"
fish_dir="$HOME/.config/fish"
create_symlink $fish $fish_dir

gitconfig="config"
git_dir="$HOME/.config/git"
create_symlink $gitconfig $git_dir


ghci="ghci.conf"
ghci_dir="$HOME/.ghc"
create_symlink $ghci $ghci_dir

editorconfig=".editorconfig"
create_symlink $editorconfig


ln -s "$ROOT/config/nushell" "$HOME/.config/nushell"
