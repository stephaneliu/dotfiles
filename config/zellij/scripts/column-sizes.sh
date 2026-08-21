#!/usr/bin/env bash
# Resize the panes of the active tab inside their own column.
#
#   column-sizes.sh zoom  - grow the focused pane to fill its column, shrinking
#                           its neighbours to the minimum height zellij allows.
#                           Run it again on an already zoomed column to even
#                           that column back out.
#   column-sizes.sh even  - give every pane in every column the same height.
#
# Zellij has no action for either, and the ones that look close by are no good:
# ToggleFocusFullscreen covers the whole tab, NextSwapLayout only works on tabs
# whose layout declares a matching swap layout, and override-layout respawns
# command panes instead of adopting them. What is left is `resize`, which only
# ever moves a border between two panes: nothing is closed, restarted or
# reordered, and other columns are untouched.
#
# `resize` moves one border by 5% of the tab per call, so the work is planned in
# percentages: read the geometry once (a read costs ~1s, a resize ~30ms), work
# out where every border in the column should end up, then fire the resizes.
# Only `decrease` is used - it stops cleanly at zellij's minimum pane height,
# while a blocked `increase` starts pushing the border the other way.
#
# Bound to Ctrl+a Z / Ctrl+a = in tmux mode (see config.kdl). Both run this in a
# floating pane: that pane is skipped when reading the layout, and the tiled
# pane underneath keeps its focus flag, which is how `zoom` finds its target.

set -uo pipefail

FLOOR=5      # rows: zellij refuses to shrink a pane below this
STEP_PCT=5   # percentage of the tab a single resize call moves a border by

mode="${1:-even}"
case "$mode" in
  zoom | even) ;;
  *)
    echo "usage: ${0##*/} zoom|even" >&2
    exit 2
    ;;
esac

command -v jq >/dev/null 2>&1 || exit 1

panes_json="$(zellij action list-panes --geometry --state --tab --json 2>/dev/null)" || exit 1
[[ -n "$panes_json" ]] || exit 1

# One line per pane of the grid on this tab, sorted into columns:
#   <pane id> <x> <y> <rows> <columns> <focused 0|1>
# Full width single row panes (the zellaude / zjstatus bars) and the floating
# pane this script runs in are left out.
grid="$(
  jq -r --arg self "${ZELLIJ_PANE_ID:-}" '
    ( [ .[] | select((.is_plugin | not) and (.id | tostring) == $self) ][0].tab_position ) as $tab
    | if $tab == null then empty else . end
    | [ .[] | select(.tab_position == $tab and (.is_floating | not) and (.is_suppressed | not)) ] as $all
    | ($all | map(.pane_x + .pane_columns) | max) as $width
    | [ $all[] | select(.pane_rows > 1 or .pane_columns < $width) ]
    | sort_by(.pane_x, .pane_y)[]
    | [ (if .is_plugin then "plugin_" else "terminal_" end) + (.id | tostring),
        .pane_x, .pane_y, .pane_rows, .pane_columns, (if .is_focused then 1 else 0 end) ]
    | @tsv
  ' <<<"$panes_json"
)" || exit 1

[[ -n "$grid" ]] || exit 1

# Plan the resizes: for every column work out the height each of its panes
# should end up with, turn that into border positions, and walk each border to
# where it belongs. A border is only moved as far as the pane giving up the rows
# can afford; borders that still owe rows are picked up on the next pass, once
# their neighbour has room.
plan="$(
  awk -v mode="$mode" -v floor="$FLOOR" -v step_pct="$STEP_PCT" '
    BEGIN { FS = "\t" }
    { n++; id[n] = $1; x[n] = $2; y[n] = $3; rows[n] = $4; cols[n] = $5; foc[n] = $6 }

    function plan_column(lo, hi,    i, cnt, height, step, focused, zoomed, bias,
                         passes, moved, delta, want, avail, take, gain, k,
                         cur, tgt, bcur, btgt) {
      cnt = hi - lo + 1
      if (cnt < 2) return
      height = (y[hi] + rows[hi]) - y[lo]

      # Only a plain stack of equal width panes is a column we understand; a
      # nested split shares an x but breaks one of these, and is left alone.
      for (i = lo; i <= hi; i++) {
        if (cols[i] != cols[lo]) return
        if (i > lo && y[i] != y[i - 1] + rows[i - 1]) return
      }

      focused = 0
      for (i = lo; i <= hi; i++) if (foc[i]) focused = i
      if (mode == "zoom" && !focused) return

      step = height * step_pct / 100
      if (step < 1) step = 1

      # A column that is already zoomed - every other pane down at the floor and
      # the focused one holding most of the column - toggles back to even.
      zoomed = (focused && rows[focused] >= 1.5 * height / cnt)
      for (i = lo; i <= hi; i++)
        if (i != focused && rows[i] > floor + step) zoomed = 0

      # Zooming aims every neighbour at the floor, so round its step counts up:
      # overshooting is free, while stopping short leaves rows on the table.
      bias = (mode == "zoom" && !zoomed) ? 0.999 : 0.5

      for (i = lo; i <= hi; i++) {
        if (mode == "zoom" && !zoomed)
          tgt[i] = (i == focused) ? height - (cnt - 1) * floor : floor
        else
          tgt[i] = int(height * (i - lo + 1) / cnt + 0.5) - int(height * (i - lo) / cnt + 0.5)
        cur[i] = rows[i]
      }

      # Cumulative row of each border, i.e. the bottom edge of pane i.
      bcur[lo - 1] = btgt[lo - 1] = y[lo]
      for (i = lo; i <= hi; i++) {
        bcur[i] = bcur[i - 1] + cur[i]
        btgt[i] = btgt[i - 1] + tgt[i]
      }

      for (passes = 0; passes < 2 * cnt; passes++) {
        moved = 0
        for (i = lo; i < hi; i++) {
          delta = btgt[i] - bcur[i]
          if (delta >= -step / 2 && delta <= step / 2) continue
          want = int((delta < 0 ? -delta : delta) / step + bias)
          if (want < 1) continue
          # Moving the border down shrinks the pane below it, and vice versa.
          # One step more than the pane can spare is fine: `decrease` stops at
          # the floor, so the last call is at worst a no-op.
          k = (delta > 0) ? i + 1 : i
          avail = int((cur[k] - floor) / step) + 1
          take = (want < avail) ? want : avail
          if (take < 1) continue
          gain = take * step
          if (cur[k] - gain < floor) gain = cur[k] - floor
          if (gain < 1) continue
          if (delta > 0) print id[i + 1] "\tdecrease\tup\t" take
          else           print id[i] "\tdecrease\tdown\t" take
          cur[i]     += (delta > 0 ?  gain : -gain)
          cur[i + 1] += (delta > 0 ? -gain :  gain)
          bcur[i]    += (delta > 0 ?  gain : -gain)
          moved = 1
        }
        if (!moved) break
      }
    }

    END {
      lo = 1
      for (i = 2; i <= n; i++)
        if (x[i] != x[lo]) { plan_column(lo, i - 1); lo = i }
      plan_column(lo, n)
    }
  ' <<<"$grid"
)" || exit 1

[[ -n "$plan" ]] || exit 0

# COLUMN_SIZES_DEBUG=1 prints the planned resizes instead of running them.
if [[ -n "${COLUMN_SIZES_DEBUG:-}" ]]; then
  printf '%s\n' "$plan"
  exit 0
fi

while IFS=$'\t' read -r pane_id action direction count; do
  for ((i = 0; i < count; i++)); do
    zellij action resize --pane-id "$pane_id" "$action" "$direction" >/dev/null 2>&1
  done
done <<<"$plan"
