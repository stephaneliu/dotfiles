# `dip rails console - defaults to attaching to existing. Option to restart`
function drc() {
  local restart=0 && [[ "$1" == "-r" ]] && restart=1
  local rc_id=$(_docker_id rails\ c)


  if [ "$(docker ps -a -q -f id=$rc_id)" ]; then
    if [ $restart -gt 0 ]; then
      echo "Restarting rails console container"

      docker stop $rc_id > /dev/null && dip CLEAN_LOGS=1 rails c
    else
      echo "### Reusing existing container ###"
      docker exec -it $rc_id bin/rails c
    fi
  else
    echo "### Starting new container from image ###"
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
      echo "### Reusing existing container ###"
      docker exec -it $sh_id /bin/bash
    fi
  else
    echo "### Starting new container from image ###"
    dip sh
  fi
}

function _docker_id() {
  docker ps --no-trunc --format "{{.ID}}-{{.Command}}" | grep $1 | cut -d '-' -f 1
}

alias dip='dip CLEAN_LOGS=1'
alias ddip='dip CLEAN_LOGS=1 DEBUG_LOGS=true'

alias dg="dip GUARD_GQL_SCHEMA=1 guard"
alias dgd="ddip GUARD_GQL_SCHEMA=1 TEST_DEBUG=1 guard"

alias dr="dip rails"
alias ddr="ddip rails"

alias drs="dip up -d sidekiq vite && dip rails s"
alias drss="dip up -d vite && dip up rails sidekiq"
alias ddrs="ddip up -d sidekiq vite && ddip rails s"
alias ddrss="ddip up -d vite && ddip up rails sidekiq"

alias dbe="dip bundle exec"
alias ddbe="ddip bundle exec"

alias did="dip down"
