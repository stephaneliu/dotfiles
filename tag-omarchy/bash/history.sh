# Match Oh My Zsh's history-substring-search: Up/Down finds the typed text
# anywhere in a command, keeping the original query while browsing matches.
_dotfiles_history_sync() {
  builtin history -a
  builtin history -n
  unset _dotfiles_history_last
}

# Share history with newly opened panes without waiting for shell exit.
# Keep Omarchy/Starship's existing prompt commands and avoid duplicate hooks.
if [[ " ${PROMPT_COMMAND[*]-} " != *" _dotfiles_history_sync "* ]]; then
  if [[ $(declare -p PROMPT_COMMAND 2>/dev/null) == 'declare -a '* ]]; then
    PROMPT_COMMAND=(_dotfiles_history_sync "${PROMPT_COMMAND[@]}")
  else
    PROMPT_COMMAND=(_dotfiles_history_sync "${PROMPT_COMMAND-}")
  fi
fi

_dotfiles_history_search() {
  local direction=$1 entry command candidate
  if [[ ! ${_dotfiles_history_last+x} || $READLINE_LINE != "$_dotfiles_history_last" ]]; then
    _dotfiles_history_query=$READLINE_LINE
    _dotfiles_history_matches=()
    local -A seen=()
    while IFS= read -r entry; do
      if [[ $entry =~ ^[[:space:]]*[0-9]+[[:space:]]+(.*)$ ]]; then
        command=${BASH_REMATCH[1]}
        if [[ -n $command && $command == *"$_dotfiles_history_query"* ]] &&
           [[ -z $_dotfiles_history_query || ! ${seen["$command"]+exists} ]]; then
          _dotfiles_history_matches+=("$command")
          seen["$command"]=1
        fi
      fi
    done < <(HISTTIMEFORMAT= builtin history | tac)
    _dotfiles_history_index=-1
  fi

  candidate=$((_dotfiles_history_index + direction))
  if (( candidate >= 0 && candidate < ${#_dotfiles_history_matches[@]} )); then
    _dotfiles_history_index=$candidate
    READLINE_LINE=${_dotfiles_history_matches[candidate]}
  elif (( candidate < 0 )); then
    _dotfiles_history_index=-1
    READLINE_LINE=$_dotfiles_history_query
  fi
  READLINE_POINT=${#READLINE_LINE}
  _dotfiles_history_last=$READLINE_LINE
}

for _dotfiles_history_keymap in vi-insert vi-command; do
  bind -m "$_dotfiles_history_keymap" -x '"\e[A":_dotfiles_history_search 1'
  bind -m "$_dotfiles_history_keymap" -x '"\e[B":_dotfiles_history_search -1'
  bind -m "$_dotfiles_history_keymap" -x '"\eOA":_dotfiles_history_search 1'
  bind -m "$_dotfiles_history_keymap" -x '"\eOB":_dotfiles_history_search -1'
done
unset _dotfiles_history_keymap

# In vi command mode, search matches with the usual history navigation keys.
bind -m vi-command -x '"k":_dotfiles_history_search 1'
bind -m vi-command -x '"j":_dotfiles_history_search -1'
