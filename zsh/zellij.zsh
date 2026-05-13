alias zj="zellij"
alias zjl="zellij list-sessions"

# Persist cwd per pane in the AI layout. Paired with
# config/zellij/layouts/ai.kdl + scripts/ai-pane-restore.sh, which export
# $ZELLIJ_AI_PANE and cd to the cached dir when the pane starts.
_zellij_ai_persist_cwd() {
  [[ -n "${ZELLIJ_AI_PANE:-}" ]] || return 0
  local session="${ZELLIJ_SESSION_NAME:-default}"
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zellij-ai/$session"
  [[ -d "$cache_dir" ]] || mkdir -p "$cache_dir" 2>/dev/null || return 0
  print -r -- "$PWD" >| "$cache_dir/$ZELLIJ_AI_PANE"
}
typeset -ga chpwd_functions
chpwd_functions+=(_zellij_ai_persist_cwd)

# Completion for zja - list active session names
_zja() {
  local sessions=(${(f)"$(zellij list-sessions -ns 2>/dev/null | grep -v EXITED)"})
  _describe 'session' sessions
}
compdef _zja zja

# Attach to session by index or name
# Usage: zja [index|name]
#   zja      - attach to first session or create new
#   zja 0    - attach to first session
#   zja 2    - attach to third session
#   zja name - attach to session by name
zja() {
  if [[ -z "$1" ]]; then
    zellij attach
    return
  fi

  if [[ "$1" =~ ^[0-9]+$ ]]; then
    local sessions=(${(f)"$(zellij list-sessions -ns 2>/dev/null | grep -v EXITED)"})
    if [[ ${#sessions[@]} -eq 0 ]]; then
      echo "No active sessions"
      return 1
    fi
    local idx=$(($1 + 1))  # zsh arrays are 1-indexed
    if [[ $idx -gt ${#sessions[@]} ]]; then
      echo "Index $1 out of range (0-$((${#sessions[@]} - 1)))"
      return 1
    fi
    zellij attach "${sessions[$idx]}"
  else
    zellij attach "$1"
  fi
}
