#!/usr/bin/env bash
# Capture current pane titles for the active tab, then close it.
# Bound to Ctrl+a X in tmux mode via config.kdl. Runs in a floating pane so
# the save completes BEFORE close-tab sends SIGHUP to the terminal panes,
# eliminating the race where shells' zshexit hooks might fail to reach zellij
# during teardown.
#
# Layout-name -> pane-id mapping comes from ~/.cache/zellij-ai/<session>/.id_<id>
# markers dropped by ai-pane-restore.sh on each pane's startup.

set -u

session="${ZELLIJ_SESSION_NAME:-default}"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zellij-ai/$session"

panes_json="$(zellij action list-panes --json 2>/dev/null)"
tab_name="$(printf '%s' "$panes_json" \
  | jq -r '[.[] | select(.is_focused == true)][0].tab_name // empty' 2>/dev/null)"

if [[ -n "$tab_name" && -d "$cache_dir" ]]; then
  printf '%s' "$panes_json" \
    | jq -r --arg tab "$tab_name" '
        .[] | select((.is_plugin | not) and .tab_name == $tab) | "\(.id)\t\(.title)"
      ' 2>/dev/null \
    | while IFS=$'\t' read -r pane_id title; do
        marker="$cache_dir/.id_$pane_id"
        [[ -r "$marker" ]] || continue
        layout_name="$(<"$marker")"
        [[ -n "$layout_name" ]] || continue
        # Defense in depth: never persist a plugin URL as a pane name.
        case "$title" in
          file:*|http:*|https:*|zellij:*) continue ;;
        esac
        printf '%s\n' "$title" >| "$cache_dir/$layout_name.name"
      done
fi

zellij action close-tab
