source $HOME/bin/os_type.sh

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(colored-man code-dir command-not-found history-substring-search vi-mode web-search z autojump)

if is_ubuntu; then
  plugins+=chucknorris
fi
  
source $ZSH/oh-my-zsh.sh

if is_ubuntu; then
  chuck_cow
fi
