##################################### general applicable ####################################################
# alias g="egrep --exclude=\*.svn\* --color=auto -r -n "
alias gre="find . -type f|grep rb$|xargs grep --color=auto"  # only grep rb files
alias ..="cd .."                                            # up one directory
alias ..2="cd ../../"                                       # up two directories
alias ..3="cd ../../../"                                    # up three directories
alias ..4="cd ../../../../"                                 # up four directories
alias ..5="cd ../../../../../"                              # up five directories
alias :q="exit"                                             # close bash terminal
alias 'ps?'='ps aux | g '
alias l='ls -alFHh'
alias ll='ls -CFHh'

alias 'q;'='exit'
alias code="echo use 'j'-jump"
alias d1="echo use 'j'-jump"
alias gg='clear'
# Use modern regexps for grep show color when `grep` is the final command
# but not when piping into something else because the added color codes will
# mess up the expected input
alias grep="egrep --color=auto"
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
