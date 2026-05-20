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

# Persist the current pane title so renames survive session restarts.
# Backgrounded so the list-panes IPC call never blocks the prompt.
#
# Race-avoidance: when ai-pane-restore.sh fires rename-pane, the title may
# still read as the layout default ($ZELLIJ_AI_PANE, e.g. "ai-1") for the
# first prompt or two before zellij applies the rename. If we see the
# default title AND the cache already holds a non-default name, treat that
# as the transient post-restore state and skip the write. Trade-off: a user
# who deliberately renames back to the layout default won't have that
# captured — they'd need to delete the .name cache file.
_zellij_ai_persist_pane_name() {
  [[ -n "${ZELLIJ_AI_PANE:-}" ]] || return 0
  [[ -n "${ZELLIJ_PANE_ID:-}" ]] || return 0
  local session="${ZELLIJ_SESSION_NAME:-default}"
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zellij-ai/$session"
  local cache_file="$cache_dir/$ZELLIJ_AI_PANE.name"
  local pane_id="$ZELLIJ_PANE_ID" default_name="$ZELLIJ_AI_PANE"
  (
    local title
    title="$(zellij action list-panes --json 2>/dev/null \
      | jq -r --argjson id "$pane_id" '.[] | select(.id == $id) | .title' \
      | head -1)"
    [[ -n "$title" ]] || exit 0
    if [[ "$title" == "$default_name" && -r "$cache_file" ]]; then
      local cached
      cached="$(<"$cache_file")"
      [[ "$cached" != "$default_name" ]] && exit 0
    fi
    mkdir -p "$cache_dir" 2>/dev/null || exit 0
    print -r -- "$title" >| "$cache_file"
  ) &!
}
typeset -ga precmd_functions
precmd_functions+=(_zellij_ai_persist_pane_name)

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
