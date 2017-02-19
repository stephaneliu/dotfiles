# g without arguments will run `git status`
function g {
  if [[ $# > 0 ]]; then
    hub $@
  else
    hub st
  fi
}

alias gad='git add'
alias gbr='git branch'
alias gcl='git clone'
alias gco='git checkout'
alias gci='git commit'
alias gdf='git diff'
alias ggg='git g'
alias gpl='git pull'
alias gps='git push'
alias gst='git stash'
