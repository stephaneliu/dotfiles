# g without arguments will run `git status`
function g {
  if [[ $# > 0 ]]; then
    hub $@
  else
    hub st
  fi
}
