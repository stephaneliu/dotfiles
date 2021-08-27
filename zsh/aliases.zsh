alias 'ps?'='ps aux | gr '
alias ..="cd .."
alias :q="exit"
alias cat='bat'
alias gg='clear'
alias h='heroku'
alias hr='heroku run'
alias inet='ifconfig | grep inet'
alias j='z'
alias l='ls -alFHh'
alias ll='ls -CFHh'
alias lol='LOLCOMMITS_DIR=/Users/sliu/Documents/lolcommits lolcommits --capture --delay "$LOL_DELAY" --fork --device "$WEBCAM"'
alias loll='LOLCOMMITS_DIR=/Users/sliu/Documents/lolcommits lolcommits --last'
alias matrix='cmatrix'
alias nc='nocorrect'
alias q='exit'
alias rcup='rcup -v'
alias screencast='ffmpeg -f x11grab -r 25 -s 1600x1200 -i :0.0 ~/tmp/output.mpg'
alias ssh='TERM=xterm ssh'
alias terminal-notifier='reattach-to-user-namespace terminal-notifier'
alias tmux="echo \"Use 't' instead\";tmux -2"
t() {
  # session with name $1 or focus
  session_name=${1:-focus}

  if tmux list-sessions | grep -q ${session_name}; then
    tmux -2 attach-session -t $session_name
  else
    tmux -2 new -t $session_name
  fi
}
alias version='bat /etc/issue'
alias vim="echo \"Use v\""
alias v='nvim'
alias vpnip='ifconfig | grep inet | grep "128\|198" | grep netmask | cut -d " " -f 2'
alias which="which -a"

# Use modern regexps for grep show color when `grep` is the final command
# but not when piping into something else because the added color codes will
# mess up the expected input
#               --- lines before match
#               |    ---lines after match
#               |    |    ---line numbers
#               |    |    |
alias -g rg="rg -A 2 -B 2 -n --color=auto"
