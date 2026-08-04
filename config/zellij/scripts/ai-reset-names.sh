#!/usr/bin/env bash
# Reset pane titles on the active tab back to their canonical AI layout slot
# names (ai-1 .. ai-12). Bound to Ctrl+a S in tmux mode via config.kdl. Runs
# in a floating pane so the renames land against the underlying tab.
#
# The pane-id -> slot-name mapping comes from ~/.cache/zellij-ai/<session>/.id_<id>
# markers dropped by ai-pane-restore.sh on each pane's startup — the same
# mapping ai-save-tab.sh uses. This is the naming counterpart to Ctrl+a R,
# which resets pane positions via NextSwapLayout.

set -u

session="${ZELLIJ_SESSION_NAME:-default}"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zellij-ai/$session"

panes_json="$(zellij action list-panes --json 2>/dev/null)"
tab_name="$(printf '%s' "$panes_json" \
  | jq -r '[.[] | select(.is_focused == true)][0].tab_name // empty' 2>/dev/null)"

if [[ -n "$tab_name" && -d "$cache_dir" ]]; then
  printf '%s' "$panes_json" \
    | jq -r --arg tab "$tab_name" '
        .[] | select((.is_plugin | not) and .tab_name == $tab) | .id
      ' 2>/dev/null \
    | while IFS= read -r pane_id; do
        marker="$cache_dir/.id_$pane_id"
        [[ -r "$marker" ]] || continue
        slot_name="$(<"$marker")"
        [[ -n "$slot_name" ]] || continue
        zellij action rename-pane --pane-id "terminal_$pane_id" "$slot_name" >/dev/null 2>&1 || true
      done
fi
