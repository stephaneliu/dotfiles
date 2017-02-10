# g without arguments will run `git status`
function g {
  if [[ $# > 0 ]]; then
    hub $@
  else
    hub st
  fi
}

alias gad='git add'
alias gco='git checkout'
alias gci='git commit'
alias ggg='git g'
alias gpl='git pull'
alias gps='git push'
