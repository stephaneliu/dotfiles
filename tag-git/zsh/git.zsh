# g without arguments will run `git status`
function g {
  if [[ $# > 0 ]]; then
    hub $@
  else
    hub st
  fi
}

alias gad='hub add'
alias gbr='hub branch'
alias gcl='hub clone'
alias gco='hub checkout'
alias gci='hub commit'
alias gdf='hub diff'
alias ggg='hub g'
alias glg='hub l'
alias gll='hub lola'
alias gmg='hub mg'
alias gmt='hub mergetool'
alias gmv='hub mv'
alias gpl='hub pull'
alias gps='hub push'
alias grb='hub rebase'
alias grf='hub rm -rf'
alias grm='hub rm'
alias gst='hub stash'
alias gus='hub unstage'

# Disable popup dialog for password on CENTOS
unset SSH_ASKPASS
