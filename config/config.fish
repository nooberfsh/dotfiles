set fish_greeting

set -x HDX "$HOME/hdx"


# rust
set -x CARGO_HOME "$HDX/apps/cargo"
set -x RUSTUP_HOME "$HDX/apps/rustup"


# haskell
set -x GHCUP_INSTALL_BASE_PREFIX "$HDX/apps"
# this is not a offical env
set -x GHCUP_HOME "$GHCUP_INSTALL_BASE_PREFIX/.ghcup"
set -x STACK_ROOT "$HDX/apps/stack"


# system default editor
set -x VISUAL "nvim"
set -x EDITOR "$VISUAL"

# path
set -x PATH "$HOME/.local/bin:$GHCUP_HOME/bin:$CARGO_HOME/bin:$HDX/bin:$PATH"


#################################################################################################### 
# fish alias

alias ee="nvim $HOME/.config/fish/config.fish && source $HOME/.config/fish/config.fish"


#################################################################################################### 
# phoronix test alias

alias pts="phoronix-test-suite"
alias pts_l="pts list-available-tests"
alias pts_ll="pts list-available-suites"
alias pts_b="pts benchmark"


#################################################################################################### 
# git alias

alias glg="git lg"
alias glg1="git lg1"
alias glg2="git lg2"
alias glg3="git lg3"
alias gst="git status"
alias gco="git checkout"
alias grb="git rebase"
alias grbm="git rebase master"
alias gcm="git commit -m"
alias gcam="git commit -a -m"
alias gpf="git push --force-with-lease"
alias gpo="git pull origin"
alias gf="git fetch"
# https://stackoverflow.com/questions/3216360/merge-update-and-pull-git-branches-without-using-checkouts
alias gfm="git fetch origin master:master"

