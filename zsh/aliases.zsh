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

alias code="echo use 'j'"
alias d1="echo use 'j'"
alias w2="echo use 'j'"
alias w3="echo use 'j'"
alias w4="echo use 'j'"
alias screencast='ffmpeg -f x11grab -r 25 -s 1600x1200 -i :0.0 /tmp/output.mpg'
alias version='cat /etc/issue'
alias gg='clear'
alias ssh='TERM=xterm ssh'
alias mr='mysql -u root'

alias which="which -a"
# Use modern regexps for grep show color when `grep` is the final command
# but not when piping into something else because the added color codes will
# mess up the expected input
alias grep="egrep --color=auto"

alias nc='nocorrect'
alias 'q;'='exit'
alias t='exit'
alias q='exit'

alias netr='nmcli networking off && nmcli networking on && sleep 10 && ifconfig | grep inet'
alias inet='ifconfig | grep inet'
