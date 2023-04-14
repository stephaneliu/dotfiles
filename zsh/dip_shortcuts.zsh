function drc() {
  local restart=0 && [[ "$1" == "-r" ]] && restart=1

  local rc_id=$(docker ps --format "{{.ID}}-{{.Command}}" | grep rails\ c | cut -d '-' -f 1)

  if [ "$(docker ps -a -q -f id=$rc_id)" ]; then
    if [ $restart -gt 0 ]; then
      echo "Restarting rails console container"
      docker stop $rc_id > /dev/null && dip rails c
    else
      docker exec -it $rc_id bin/rails c
    fi
  else
    dip rails c
  fi
}

function dsh() {
  local restart=0 && [[ "$1" == "-r" ]] && restart=1

  local sh_id=$(docker ps --format "{{.ID}}-{{.Command}}" | grep bin/bash | cut -d '-' -f 1)

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

alias dg="dip guard"
alias dr="dip rails"
alias drs="dip compose up -d sidekiq webpacker && dip rails s"
alias ddown="dip compose down"
alias dbe="dip bundle exec"
