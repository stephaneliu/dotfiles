# g without arguments will run `git status`
function g {
  if [[ $# > 0 ]]; then
    hub $@
  else
    hub st
  fi
}

alias gp='git pull'
alias gc='git checkout'
alias gcm='git commit'
alias gg='git g'
