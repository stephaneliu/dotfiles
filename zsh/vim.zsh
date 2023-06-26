# bind k and j for VI mode to history search
# Type a letter/word, jk (escape), j or k (search)
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# jk - from insert to normal
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
