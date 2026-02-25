# Auto-start zellij in Ghostty (must be before p10k instant prompt)
if [[ "$TERM" == "xterm-ghostty" ]] && [[ -z "$ZELLIJ" ]]; then
  zellij attach -c
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

BASE="$HOME/.zsh"

load_all_files_in() {
  if [ -d "$BASE/$1" ]; then
    for file in "$BASE/$1"/*.zsh; do
      # SECONDS=0
      source "$file"
      # echo "$file load time: $SECONDS"
    done
  fi
}

load_all_files_in before
load_all_files_in ""
load_all_files_in after

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

if [ -e $HOME/.zsh.docker ]; then
  source $HOME/.zsh.docker
fi

if [ -e $HOME/.private_keys ]; then
  source $HOME/.private_keys
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
