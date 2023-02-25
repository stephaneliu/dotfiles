# Support for 256 colors
set -g default-terminal "screen-256color"

# COLOR Solarized dark
# default statusbar colors
set-option -g status-bg black #base02
set-option -g status-fg yellow #yellow
set-option -g status-style default

# highlight status bar on activity
setw -g monitor-activity on
set -g visual-activity on
set -g visual-bell on

# automatically set window title
set -g automatic-rename off
set -g allow-rename off

# pane border
  set -g pane-border-style fg=color244
  set -g pane-active-border-style fg=color208,bg=default

# Window index base 1
set -g base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

# default window title colors
set-window-option -g window-status-style fg=brightblue
set-window-option -g window-status-style bg=default
#set-window-option -g window-status-attr dim

# active window title colors
set-window-option -g window-status-current-style fg=brightred
set-window-option -g window-status-current-style bg=default
#set-window-option -g window-status-current-attr bright

# message text
set-option -g message-style bg=black
set-option -g message-style fg=brightred

# pane number display
set-option -g display-panes-active-color blue #blue
set-option -g display-panes-color brightred #orange

# clock
set-window-option -g clock-mode-color green #green
