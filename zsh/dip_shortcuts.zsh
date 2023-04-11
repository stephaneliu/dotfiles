function drc() {
  local rc_id=$(docker ps --format "{{.ID}}-{{.Command}}" | grep rails\ c | cut -d '-' -f 1)

  if [ "$(docker ps -a -q -f id=$rc_id)" ]; then
    docker exec -it $rc_id bin/rails c
  else
    dip rails c
  fi
}

alias dsh="dip sh"
alias dg="dip guard"
alias dr="dip rails"
alias drs="dip compose up -d sidekiq webpacker && dip rails s"
alias ddown="dip compose down"
alias dbe="dip bundle exec"
