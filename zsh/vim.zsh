# use jk/kj for command-mode
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode
# bind k and j for VI mode to history search
# Type a letter/word, jk (escape), j or k (search)
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

