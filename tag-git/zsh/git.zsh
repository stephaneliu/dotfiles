# g without arguments will run `git status`
function g {
  if [[ $# > 0 ]]; then
    hub $@
  else
    hub st
  fi
}

alias ga='git add'
alias gc='git checkout'
alias gci='git commit'
alias gg='git g'
alias gp='git pull'
