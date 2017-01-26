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

alias code="cd ~/code"                              # location of rails_project 
alias d1="cd ~/.dotfiles"
alias g2="cd ~/code/vim_notes/"
alias g3="cd ~/code/tmux.conf"
alias g4="cd ~/code/git_sync"
alias w1="cd ~/code/"
alias w1="cd ~/code/mcg"
alias w2="cd ~/code/netops/src"
alias w2e="cd ~/code/netops/src && vi app/models/event.rb" # location of netops
alias w3="cd ~/code/iatp; . ./.rvmrc"             # location of iatp & switch ruby enterprise
alias w4="cd ~/code/netops-datasources"           # location of netops-datasources
alias w5="cd ~/code/dots/src"                      # location of iatp & switch ruby enterprise
alias w6="cd ~/code/hc"
alias w6b="cd ~/code/hicrane"
alias w7="cd ~/code/kc"
alias w7e="vi ~/code/kc/app/models/invoice.rb"
alias w8="cd ~/code/flylow"                   # location of gitosis dh
alias w9="cd ~/code/netops-proxy"                 # location of gitosis oama
alias w99="cd ~/code/ra3"                         # location of gitosis oama
alias code='cd ~/code'
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
