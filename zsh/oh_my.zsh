is_linux() { [ "$(uname -s)" = Linux ] }

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(colored-man code-dir command-not-found history-substring-search vi-mode web-search z)

if is_linux; then
  plugins+=chucknorris
fi
  
source $ZSH/oh-my-zsh.sh

if is_linux; then
  chuck_cow
fi

