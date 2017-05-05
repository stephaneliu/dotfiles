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

if is_ubuntu; then
  source $HOME/.zsh/aliases.zsh.linux
  # Current work around until deprecate PC
  . "/$HOME/cac-enabled-git-env.sh"
  disable_cac_aware_git
fi

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
compdef _git gpl=git-pull
compdef _git gps=git-push
compdef _git grm=git-rm
compdef _git grf=git-rm
compdef _git gst=git-stash
compdef _git gus=git-reset

chruby ruby
