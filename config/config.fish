set fish_greeting

set -x HDX "$HOME/hdx"
set -x CARGO_HOME "$HDX/apps/cargo"
set -x RUSTUP_HOME "$HDX/apps/rustup"
set -x GOPATH "$HDX/apps/go"

set -x PATH "$HDX/apps/go/bin:$HDX/apps/cargo/bin:$HDX/bin:$PATH"

set -x VISUAL "nvim"
set -x EDITOR "$VISUAL"

alias pts="phoronix-test-suite"
alias ee="nvim $HOME/.config/fish/config.fish"
