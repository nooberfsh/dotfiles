set fish_greeting

set -x HDX "$HOME/hdx"
set -x CARGO_HOME "$HDX/apps/cargo"
set -x RUSTUP_HOME "$HDX/apps/rustup"
set -x GOPATH "$HDX/apps/go"
set -x SNAP_HOME "/var/lib/snapd"

# system default editor
set -x VISUAL "nvim"
set -x EDITOR "$VISUAL"
# path
set -x PATH "$SNAP_HOME/snap/bin:$HDX/apps/go/bin:$HDX/apps/cargo/bin:$HDX/bin:$PATH"



#################################################################################################### 
# normal alias

alias ee="nvim $HOME/.config/fish/config.fish && source $HOME/.config/fish/config.fish"
alias pts="phoronix-test-suite"


#################################################################################################### 
# git alias

alias glg="git lg"
alias glg1="git lg1"
alias glg2="git lg2"
alias glg3="git lg3"
alias gst="git status"
alias gco="git checkout"
alias grb="git rebase"
alias gcm="git commit -m"
alias gcam="git commit -a -m"
alias gpf="git push --force-with-lease"
alias gf="git fetch"
# https://stackoverflow.com/questions/3216360/merge-update-and-pull-git-branches-without-using-checkouts
# alias gsync="git checkout --detach && git fetch origin master:master && git checkout -"
