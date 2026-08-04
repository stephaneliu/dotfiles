#!/usr/bin/env bash
# Restore the last cwd and pane title for a named pane in the AI zellij
# layout. Invoked by ai.kdl as each pane's command; matching hooks in
# zsh/zellij.zsh write $PWD and the current pane title back to
# ~/.cache/zellij-ai/<session>/<pane-name>{,.name}.

set -u

pane_name="${1:?pane name required}"
session="${ZELLIJ_SESSION_NAME:-default}"
cache_root="${XDG_CACHE_HOME:-$HOME/.cache}/zellij-ai"
cache_dir="$cache_root/$session"

mkdir -p "$cache_dir"

# Read a cached value for this pane. Falls back to the most recently saved
# value from any prior session if the current session has no cache yet.
read_cached() {
  local suffix="$1"
  local primary="$cache_dir/$pane_name$suffix"
  if [[ -r "$primary" ]]; then
    cat -- "$primary"
    return
  fi
  local fallback
  fallback="$(ls -t "$cache_root"/*/"$pane_name$suffix" 2>/dev/null | head -1)"
  if [[ -n "$fallback" && -r "$fallback" ]]; then
    cat -- "$fallback"
  fi
}

target="$(read_cached "")"
cached_name="$(read_cached ".name")"

if [[ -n "$target" && -d "$target" ]]; then
  cd "$target" || true
fi

# Restore a previously-set pane title. Synchronous so the rename has a chance
# to land before zsh's precmd hook starts polling list-panes — see the
# race-avoidance comment in zsh/zellij.zsh.
if [[ -n "$cached_name" && "$cached_name" != "$pane_name" && -n "${ZELLIJ_PANE_ID:-}" ]]; then
  zellij action rename-pane --pane-id "terminal_$ZELLIJ_PANE_ID" "$cached_name" >/dev/null 2>&1 || true
fi

# Drop a pane-id -> layout-name marker so ai-save-tab.sh (bound to Ctrl+a X)
# can map list-panes IDs back to the layout slot when it captures titles
# before close-tab fires SIGHUP.
if [[ -n "${ZELLIJ_PANE_ID:-}" ]]; then
  printf '%s\n' "$pane_name" >| "$cache_dir/.id_$ZELLIJ_PANE_ID" 2>/dev/null || true
fi

export ZELLIJ_AI_PANE="$pane_name"
exec zsh -i
