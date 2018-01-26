source $HOME/bin/os_type.sh

BASE="$HOME/.zsh"


load_all_files_in() {
  if [ -d "$BASE/$1" ]; then
    for file in "$BASE/$1"/*.zsh; do
      source "$file"

    done 

    if is_ubuntu || is_redhat; then
      for file in "$BASE/$1"/*.linux; do
        source "$file"
      done
    fi
  fi
}

load_all_files_in before
load_all_files_in ""


ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

COMPLETION_WAITING_DOTS="true"
EDIPI="1241980045"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(colored-man code-dir command-not-found docker history-substring-search vi-mode web-search z autojump)

if is_ubuntu; then
  source $HOME/.zsh/aliases.zsh.linux
  # Current work around until deprecate PC
  . "/$HOME/cac-enabled-git-env.sh"
  disable_cac_aware_git
  plugins+=chucknorris
  chuck_cow
fi

if is_osx; then
  source $HOME/.zsh/aliases.zsh.osx
fi

source $ZSH/oh-my-zsh.sh

# Previously in tag-git/zsh/git.sh but zsh complaining command not found
# Complete g like git
compdef g=git
compdef _git gad=git-add
compdef _git gco=git-checkout
compdef _git gbr=git-branch
compdef _git gcl=git-clone
compdef _git gci=git-commit
compdef _git gdf=git-diff
compdef _git ggg=git-grep
compdef _git glg=git-log
compdef _git gmg=git-merge
compdef _git gmv=git-mv
compdef _git gpl=git-pull
compdef _git gps=git-push
compdef _git grm=git-rm
compdef _git grb=git-rebase
compdef _git gst=git-stash
compdef _git gus=git-reset

chruby ruby
