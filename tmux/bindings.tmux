# Remap x to kill pane without confirmation
unbind C-x
bind C-X kill-pane
bind x kill-pane

# <ctrl>-a twice for last-window
bind C-a last-window
unbind a
bind-key a last-pane

# new windows with current dir path
unbind c
bind c new-window -c "#{pane_current_path}"

# Quick gitsh pane
# unbind C-g
# bind g split-window -v -c "#{pane_current_path}" -p 50 "gitsh --git $(which gh)"
# bind C-g split-window -v -c "#{pane_current_path}" -p 50 "gitsh --git $(which git)"

# Quick rails console pane
unbind C-r
bind C-r split-window -v -c "#{pane_current_path}" -p 50 "bin/rails console"

# split windows like vim.  - Note: vim's definition of a horizontal/vertical split is reversed from tmux's
unbind s
bind s split-window -v -c "#{pane_current_path}"\; resize-pane -y 35%
bind C-s split-window -v -c "#{pane_current_path}"\; resize-pane -y 35%
bind v split-window -h -c "#{pane_current_path}" \; resize-pane -x 38%
bind C-v split-window -h -c "#{pane_current_path}" \; resize-pane -x 38%

# navigate panes with hjkl
bind h select-pane -L
bind C-h select-pane -L
bind j select-pane -D
bind C-j select-pane -D
bind k select-pane -U
bind C-k select-pane -U
bind l select-pane -R
bind C-l select-pane -R

bind C-H select-pane -L \; resize-pane -R 1000
bind C-J select-pane -D \; resize-pane -y 35%
bind C-K select-pane -U \; resize-pane -D 1000
bind C-L select-pane -R \; resize-pane -x 38%

# resize panes like vim
# -r option makes it repeatable
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

unbind =
bind _ resize-pane -D 1000
bind C-_ resize-pane -U 1000
bind = resize-pane -y 50
bind | resize-pane -R 1000

# Reset panes to custom layout
unbind C-c
bind C-c select-layout "d088,240x84,0,0{148x84,0,0[148x82,0,0,1,148x1,0,83,16],91x84,149,0[91x20,149,0,7,91x20,149,21,12,91x20,149,42,14,91x21,149,63,15]}"

# bind : to command-prompt like vim this is the default in tmux already
bind : command-prompt
# bind R source-file ~/.tmux.conf
