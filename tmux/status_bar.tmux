# Set status bar
set-window-option -g window-status-current-style bg=color17
set-window-option -g window-status-current-style fg=color27
# use vim script github.com/guns/xterm-color-table.vim' for color code
# yes you must use color
set -g status-bg color16
set -g status-fg white
set -g status-left '#[fg=color15,bg=color17]#H'
set -g status-right '#[fg=color15,bg=color17]#(uptime | cut -d"," -f 2-)'
set -g status-interval 2
set -g message-command-style fg=blue
set -g message-command-style bg=color16
