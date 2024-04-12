# `dip rails console - defaults to attaching to existing. Option to restart`
function drc() {
  local restart=0 && [[ "$1" == "-r" ]] && restart=1
  local rc_id=$(_docker_id rails\ c)


  if [ "$(docker ps -a -q -f id=$rc_id)" ]; then
    if [ $restart -gt 0 ]; then
      echo "Restarting rails console container"

      docker stop $rc_id > /dev/null && dip CLEAN_LOGS=1 rails c
    else
      docker exec -it $rc_id bin/rails c
    fi
  else
    dip CLEAN_LOGS=1 rails c
  fi
}

# `dip shell - defaults to attaching to existing. Option to restart`
function dsh() {
  local restart=0 && [[ "$1" == "-r" ]] && restart=1
  local sh_id=$(_docker_id bin/bash)

  if [ "$(docker ps -a -q -f id=$sh_id)" ]; then
    if [ $restart -gt 0 ]; then
      echo "Restarting shell container"

      docker stop $sh_id > /dev/null && dip sh
    else
      docker exec -it $sh_id /bin/bash
    fi
  else
    dip sh
  fi
}

function _docker_id() {
  docker ps --no-trunc --format "{{.ID}}-{{.Command}}" | grep $1 | cut -d '-' -f 1
}

alias dip='dip CLEAN_LOGS=1 '
alias dg="dip GUARD_GQL_SCHEMA=1 guard"
alias dr="dip rails"
alias drs="dip compose up -d sidekiq webpacker && dip rails s"
alias ddown="dip compose down"
alias dbe="dip bundle exec"
