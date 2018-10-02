##################################### general applicable ####################################################
# alias g="egrep --exclude=\*.svn\* --color=auto -r -n "
alias ..="cd .."                                            # up one directory
alias ..2="cd ../../"                                       # up two directories
alias ..3="cd ../../../"                                    # up three directories
alias ..4="cd ../../../../"                                 # up four directories
alias ..5="cd ../../../../../"                              # up five directories
alias :q="exit"                                             # close bash terminal
alias 'ps?'='ps aux | gr '
alias l='ls -alFHh'
alias ll='ls -CFHh'
alias terminal-notifier='reattach-to-user-namespace terminal-notifier'
alias tmux='TERM=xterm-256color tmux'

alias code="echo use 'j'-jump"
alias d1="echo use 'j'-jump"
alias gg='clear'
# Use modern regexps for grep show color when `grep` is the final command
# but not when piping into something else because the added color codes will
# mess up the expected input
#               --- lines before match
#               |    ---lines after match
#               |    |    ---line numbers
#               |    |    |
alias gr="rg -A 2 -B 2 -n --color=auto"
alias h='heroku'
alias hr='heroku run'
alias mr='mysql -u root'
alias nc='nocorrect'
alias q='exit'
alias screencast='ffmpeg -f x11grab -r 25 -s 1600x1200 -i :0.0 /tmp/output.mpg'
alias ssh='TERM=xterm ssh'
alias t='exit'
alias version='cat /etc/issue'
alias w2="echo use 'j'-jump"
alias w3="echo use 'j'-jump"
alias w4="echo use 'j'-jump"
alias which="which -a"

alias netr='nmcli networking off && nmcli networking on && sleep 10 && ifconfig | grep inet'
alias inet='ifconfig | grep inet'

alias d='docker'
alias dc='docker-compose'
alias dca='docker-compose up -d && docker attach --detach-keys="ctrl-q" netops_rails_1'
alias da='docker attach --detach-keys="ctrl-q" netops_rails_1'
alias dcbu='docker-compose build --build-arg dotfile_user=sliu '
alias dcst='docker-compose stop'
alias dcr='docker-compose run '

alias j='z'
