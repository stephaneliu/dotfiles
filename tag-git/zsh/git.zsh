# g without arguments will run `git status`
function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git st
  fi
}

# Complete g like git
compdef g=git
