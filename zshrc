is_osx()   { [ "$(uname -s)" = Darwin ] }
is_linux() { [ "$(uname -s)" = Linux ] }

BASE="$HOME/.zsh"

load_all_files_in() {
  if [ -d "$BASE/$1" ]; then
    for file in "$BASE/$1"/*.zsh; do
      source "$file"
    done

    if is_linux; then
      for file in "$BASE/$1"/*.linux; do
        source "$file"
      done
    fi
  fi
}

load_all_files_in before
load_all_files_in ""

if is_linux; then
  source $HOME/.zsh/aliases.zsh.linux
  # Current work around until deprecate PC
  . "/$HOME/cac-enabled-git-env.sh"
  disable_cac_aware_git
fi

compdef g=git
