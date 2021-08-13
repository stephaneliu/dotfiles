alias 'ps?'='ps aux | gr '
alias ..2="cd ../../"
alias ..3="cd ../../../"
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
alias netr='nmcli networking off && nmcli networking on && sleep 10 && ifconfig | grep inet'
alias q='exit'
alias screencast='ffmpeg -f x11grab -r 25 -s 1600x1200 -i :0.0 /tmp/output.mpg'
alias ssh='TERM=xterm ssh'
alias t='exit'
alias terminal-notifier='reattach-to-user-namespace terminal-notifier'
alias tmux='TERM=xterm-256color tmux'
alias version='bat /etc/issue'
alias vim='nvim'
alias vpnip='ifconfig | grep inet | grep "128\|198" | grep netmask | cut -d " " -f 2'
alias which="which -a"

# Use modern regexps for grep show color when `grep` is the final command
# but not when piping into something else because the added color codes will
# mess up the expected input
#               --- lines before match
#               |    ---lines after match
#               |    |    ---line numbers
#               |    |    |
alias rg="rg -A 2 -B 2 -n --color=auto"

# docker
alias d='docker'
alias dc='docker-compose'
alias dca='docker-compose up -d && docker attach --detach-keys="ctrl-q" netops_rails_1'
alias da='docker attach --detach-keys="ctrl-q" netops_rails_1'
alias dcbu='docker-compose build --build-arg dotfile_user=sliu '
alias dcst='docker-compose stop'
alias dcr='docker-compose run '
alias docdev='bin/docker_build dev'
