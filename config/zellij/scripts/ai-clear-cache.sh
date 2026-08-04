#!/usr/bin/env bash
# Delete the entire AI layout cache so the next zellij start comes up fresh —
# no restored cwd or pane titles. Bound to Ctrl+a D in tmux mode via
# config.kdl. Runs in a floating pane.
#
# We wipe the whole cache root (all sessions), not just the current session:
# ai-pane-restore.sh falls back to the most-recent cache from ANY session, so
# deleting one session's dir alone would still restore stale state on restart.
#
# The cache dir is repopulated automatically on the next layout load by
# ai-pane-restore.sh (markers) and ai-save-tab.sh (titles).

set -u

cache_root="${XDG_CACHE_HOME:-$HOME/.cache}/zellij-ai"

# Guard: only ever remove a path that ends in the expected cache dir name, so
# a mangled XDG_CACHE_HOME can never turn this into a broader rm -rf.
case "$cache_root" in
  */zellij-ai) rm -rf -- "$cache_root" ;;
  *) exit 1 ;;
esac
