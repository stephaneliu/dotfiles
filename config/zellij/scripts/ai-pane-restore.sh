#!/usr/bin/env bash
# Restore the last cwd for a named pane in the AI zellij layout.
# Invoked by ai.kdl as each pane's command; the matching chpwd hook in
# zsh/zellij.zsh writes $PWD back to ~/.cache/zellij-ai/<pane-name>.

set -u

pane_name="${1:?pane name required}"
session="${ZELLIJ_SESSION_NAME:-default}"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zellij-ai/$session"
cache_file="$cache_dir/$pane_name"

mkdir -p "$cache_dir"

target=""
if [[ -r "$cache_file" ]]; then
  target="$(<"$cache_file")"
fi

if [[ -n "$target" && -d "$target" ]]; then
  cd "$target" || true
fi

export ZELLIJ_AI_PANE="$pane_name"
exec zsh -i
