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


# install neovim and neovimplugins (:CheckHealth)
sudo pacman -S neovim python-pynvim xclip

# install vimplug
vimplug="$HOME/.local/share/nvim/site/autoload/plug.vim"
if [ -f "$vimplug" ]; then
    echo "$vimplug exist, skip"
else
    echo "$vimplug does not exist, begin to download..."
    curl -fLo $vimplug --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

#####################################################

neovim="init.vim"
neovim_dir="$HOME/.config/nvim"
create_symlink $neovim $neovim_dir

tmux="tmux.conf"
tmux_dir="$HOME/.config/tmux"
create_symlink $tmux $tmux_dir

ideavimrc="ideavimrc"
ideavim_dir="$HOME/.config/ideavim"
create_symlink $ideavimrc $ideavim_dir


gitconfig="config"
git_dir="$HOME/.config/git"
create_symlink $gitconfig $git_dir


#####################################################

profile=".profile"
create_symlink $profile

xprofile=".xprofile"
create_symlink $xprofile

pam_env=".pam_environment"
create_symlink $pam_env

zshrc=".zshrc"
create_symlink $zshrc

sbtrepo="repositories"
sbtdir="$HOME/.sbt"
create_symlink $sbtrepo $sbtdir
