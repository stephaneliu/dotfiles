source $HOME/.dotfiles/bin/os_type.sh

ZSH=$HOME/.oh-my-zsh

POWERLEVEL9K_MODE='nerdfont-complete'

if is_osx; then
  ZSH_THEME="powerlevel10k/powerlevel10k"
else
  ZSH_THEME="robbyrussell"
fi

COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(asdf colored-man-pages command-not-found copypath docker-compose heroku history-substring-search vi-mode z)

source $ZSH/oh-my-zsh.sh
