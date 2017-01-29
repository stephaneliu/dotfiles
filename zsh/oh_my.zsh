ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(colored-man code-dir command-not-found history-substring-search vi-mode web-search z)

source $ZSH/oh-my-zsh.sh

is_linux() { [ "$(uname -s)" = Linux ] }

if is_linux; then
  plugins+=chucknorris
  chuck_cow
fi
