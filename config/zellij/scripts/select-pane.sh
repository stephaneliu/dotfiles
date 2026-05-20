#!/usr/bin/env bash
# Prompt for a pane number, then focus that pane by name and zoom it.
#
# The AI layout names its grid panes "ai-1" through "ai-12". This script
# resolves the requested number to a pane ID via `zellij action list-panes`
# and focuses it directly with `focus-pane-id`, so navigation is independent
# of the surrounding status bars and the user's current cursor position.
#
# After focusing, the target pane is zoomed (fullscreen). If the tab is
# already in fullscreen mode (some other pane is currently zoomed), we skip
# the toggle — zellij carries fullscreen mode with focus changes, so the
# newly focused pane is already shown zoomed and toggling would un-zoom it.
#
# Launched as a floating Zellij pane via Ctrl+a q; the prompt pane closes
# itself once input is captured (close_on_exit on the keybind). The focus
# change must happen AFTER the floating pane closes — otherwise zellij's
# "restore previous focus" on pane-close reverts our focus change.
#
# We resolve the target pane synchronously while the floating pane still
# exists (need access to list-panes), then daemonize the focus call via
# perl's double-fork+setsid so it survives the SIGKILL zellij sends to
# the floating pane's process group on close_on_exit. A plain `& disown`
# is not enough — the backgrounded subshell still gets reaped.

read -r -p 'pane: ' n
[[ "$n" =~ ^[1-9][0-9]?$ ]] || exit 0

panes_json=$(zellij action list-panes --json 2>/dev/null)

# Resolve target pane id + already-fullscreen state in one perl pass.
# Matching cascades: (1) terminal_command ending in "ai-pane-restore.sh
# ai-N" — stable across renames, anchored so ai-1 != ai-10; (2) title
# == "ai-N" — for panes whose terminal_command was dropped on session
# restore but the user renamed the orphan back; (3) positional — from
# known panes' (pane_x, pane_y) we derive row/column centroids for the
# fixed 3x4 layout, then find the orphan pane closest to the expected
# slot for ai-N. Outputs "<id>\t<already_fs>" on one line.
read -r target_id already_fs < <(
  PANES_JSON="$panes_json" perl - "$n" <<'PERL'
use strict;
use warnings;
use JSON::PP;

my $COLS = 3;  # AI layout: 3 columns x 4 rows, row-major numbering
my $target_n = $ARGV[0] + 0;
my $panes = eval { decode_json($ENV{PANES_JSON} // '[]') } || [];

my @tiled = grep {
    !$_->{is_plugin} && !$_->{is_floating} && !$_->{is_suppressed}
} @$panes;

for my $p (@tiled) {
    my $cmd = $p->{terminal_command} // '';
    $p->{layout_n} = ($cmd =~ /ai-pane-restore\.sh ai-(\d+)$/) ? $1 + 0 : undef;
}

my $already_fs = (grep { $_->{is_fullscreen} } @tiled) ? 1 : 0;

sub resolve {
    # Primary: terminal_command match
    for my $p (@tiled) {
        return $p->{id} if defined $p->{layout_n} && $p->{layout_n} == $target_n;
    }
    # Secondary: title match
    for my $p (@tiled) {
        return $p->{id} if ($p->{title} // '') eq "ai-$target_n";
    }
    # Tertiary: positional fallback via centroids derived from known panes
    my $target_row = int(($target_n - 1) / $COLS);
    my $target_col = ($target_n - 1) % $COLS;
    my (%row_ys, %col_xs);
    for my $p (@tiled) {
        next unless defined $p->{layout_n};
        my $r = int(($p->{layout_n} - 1) / $COLS);
        my $c = ($p->{layout_n} - 1) % $COLS;
        push @{$row_ys{$r}}, $p->{pane_y};
        push @{$col_xs{$c}}, $p->{pane_x};
    }
    return undef unless exists $row_ys{$target_row} && exists $col_xs{$target_col};
    my $sum_y = 0; $sum_y += $_ for @{$row_ys{$target_row}};
    my $cy = $sum_y / scalar @{$row_ys{$target_row}};
    my $sum_x = 0; $sum_x += $_ for @{$col_xs{$target_col}};
    my $cx = $sum_x / scalar @{$col_xs{$target_col}};
    my @orphans = grep { !defined $_->{layout_n} } @tiled;
    return undef unless @orphans;
    my ($best, $best_d);
    for my $p (@orphans) {
        my $dy = $p->{pane_y} - $cy;
        my $dx = $p->{pane_x} - $cx;
        my $d = $dy * $dy + $dx * $dx;
        if (!defined $best_d || $d < $best_d) { $best_d = $d; $best = $p; }
    }
    return defined $best ? $best->{id} : undef;
}

my $id = resolve();
print defined($id) ? "$id\t$already_fs\n" : "\t$already_fs\n";
PERL
)

[[ -n "$target_id" ]] || exit 0

# Daemonize: double-fork + setsid so we escape zellij's pane process
# group. The grandchild sleeps briefly (giving the floating pane time
# to close), then performs the focus + optional fullscreen toggle.
perl - "$target_id" "${already_fs:-0}" <<'PERL'
use POSIX qw(setsid);
my ($target_id, $already_fs) = @ARGV;
my $pid = fork; exit if $pid; die "fork: $!" unless defined $pid;
setsid();
$pid = fork; exit if $pid; die "fork: $!" unless defined $pid;
open STDIN,  "</dev/null";
open STDOUT, ">/dev/null";
open STDERR, ">/dev/null";
select(undef, undef, undef, 0.15);
system("zellij", "action", "focus-pane-id", "terminal_$target_id");
if ($already_fs eq "0") {
    system("zellij", "action", "toggle-fullscreen");
}
PERL
