# Vi-mode configuration to default to insert mode
# Set vi-mode to start in insert mode
bindkey -v

# Bind 'jk' to switch to command mode
bindkey -M viins 'jk' vi-cmd-mode

# Always return to insert mode after pressing enter
function zle-line-finish {
  zle vi-insert
}
zle -N zle-line-finish

# Also ensure we start in insert mode when the shell starts
zle-line-init() {
  zle vi-insert
}
zle -N zle-line-init