# Common shortcuts using syntax supported by Bash and Zsh.
# Keep Omarchy's existing ls and tool aliases intact.
if command -v eza >/dev/null 2>&1; then
  alias l='eza -Alh --group-directories-first --icons=auto'
  alias ll='eza -Alh --group-directories-first --icons=auto'
  alias la='eza -a --group-directories-first --icons=auto'
else
  alias l='ls -Alh'
  alias ll='ls -Alh'
  alias la='ls -A'
fi

alias q='exit'
alias :q='exit'
alias gg='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias md='mkdir -p'
