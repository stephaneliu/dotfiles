# alias j to z
function j {
  if [[ $# < 1 ]]; then
    cd $HOME
  elif [[ $1 = "-" ]]; then
    cd -
  else
    z $@
  fi
}

