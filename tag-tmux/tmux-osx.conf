# Start selection like vi
setw -g mode-keys vi
unbind -T copy-mode-vi v
bind -T copy-mode-vi v send -X begin-selection

# Copy selection like vi yank
unbind-key -T copy-mode-vi y
bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel "pbcopy"
unbind -T copy-mode-vi Enter
bind-key -T copy-mode-vi Enter send -X copy-pipe-and-cancel "pbcopy"

unbind -T copy-mode-vi Space
bind -T copy-mode-vi Space send -X jump-again
bind-key -T copy-mode-vi 0 send -X bad-to-indentation
bind y run 'tmux safe-buffer - | pbcopy '
bind C-y run 'tmux save-buffer - | pbcopy '

# Default to incremental search in copy-mode
bind -T copy-mode-vi / command-prompt -i -p "search down" "send -X search-forward-incremental \"%%%\""
bind -T copy-mode-vi ? command-prompt -i -p "search up" "send -X search-backward-incremental \"%%%\""
bind / copy-mode\; command-prompt -i -p "search up" "send -X search-backward-incremental \"%%%\""
