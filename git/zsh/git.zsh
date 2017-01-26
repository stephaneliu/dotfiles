function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git st
  fi
}

alias git=hub

# Complete git
compdef g=git
