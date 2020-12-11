set fish_greeting

set -x HDX "$HOME/hdx"
set -x CARGO_HOME "$HDX/apps/cargo"
set -x RUSTUP_HOME "$HDX/apps/rustup"
set -x GOPATH "$HDX/apps/go"

# system default editor
set -x VISUAL "nvim"
set -x EDITOR "$VISUAL"
# path
set -x PATH "$HDX/apps/go/bin:$HDX/apps/cargo/bin:$HDX/bin:$PATH"



#################################################################################################### 
# normal alias

alias ee="nvim $HOME/.config/fish/config.fish"
alias pts="phoronix-test-suite"


#################################################################################################### 
# git alias

alias glg="git lg"
alias gst="git status"
alias gco="git checkout"
alias grb="git rebase"
# https://stackoverflow.com/questions/3216360/merge-update-and-pull-git-branches-without-using-checkouts
alias gsync="git checkout --quiet --detach && git fetch origin master:master && git checkout --quiet -"
