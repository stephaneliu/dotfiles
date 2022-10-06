# alias j to z
function j {
  if [[ $# < 1 ]]; then
    cd
  elif [[ $1 = "-" ]]; then
    cd -
  else
    z $@
  fi
}

alias 'ps?'='procs | ag '
alias ..="cd .."
alias :q="exit"
alias cat="bat --theme='Solarized (dark)'"
alias du='dust'
alias gg='clear'
alias h='heroku'
alias hr='heroku run'
alias inet='ifconfig | grep inet'
alias l="lsd -AlFh --size short --group-dirs last --blocks size --blocks date --blocks name --date '+%m-%d-%y %R'"
# mneumonic 'l's 'b'y 's'ize
alias lbs="lsd -AlFh --size short --group-dirs first --total-size --sort size --blocks size --blocks name"
alias ll="lsd -AlFh --size short --group-dirs last --date '+%m-%d-%y %R'"
alias lol='LOLCOMMITS_DIR=$HOME/Documents/lolcommits lolcommits --capture --fork --delay "$LOL_DELAY" --device "$WEBCAM"'
alias loll='LOLCOMMITS_DIR=$HOME/Documents/lolcommits lolcommits --last'
alias matrix='cmatrix'
alias nc='nocorrect'
alias ps='procs'
alias q='exit'
alias rcup='RCRC=$HOME/.dotfiles/rcrc rcup -fv'
alias rcdn='rcdn -v'
alias screencast='ffmpeg -f x11grab -r 25 -s 1600x1200 -i :0.0 ~/tmp/output.mpg'
alias ssh='TERM=xterm ssh'
alias terminal-notifier='reattach-to-user-namespace terminal-notifier'
alias tmux="tmux -2"
t() {
  # session with name $1 or focus
  session_name=${1:-focus}

  if tmux list-sessions 2>/dev/null | grep -q ${session_name}; then
    tmux -2 attach-session -t $session_name
  else
    tmux -2 new -t $session_name
  fi
}
alias version='bat /etc/issue'
alias vim="echo \"Use v\""
alias v='nvim +OpenSession'
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
