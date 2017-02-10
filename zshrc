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
