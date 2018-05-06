BASE="$HOME/.zsh"

load_all_files_in() {
  if [ -d "$BASE/$1" ]; then
    for file in "$BASE/$1"/*.zsh; do
      source "$file"
    done 
  fi
}

load_all_files_in before
load_all_files_in ""

if [ -e $HOME/.zsh.docker ]; then
  source $HOME/.zsh.docker
fi

# chuck_cow
export USEPG=true
