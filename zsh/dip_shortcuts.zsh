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

# The OrbStack HTTP proxy is injected into every container as http_proxy / NO_PROXY env vars; the default NO_PROXY list
# only covers OrbStack's own *.orb.internal/*.orb.local patterns and not docker-compose service names. As a result,
# Rails proxying /vite-dev/* requests to http://vite:3037 routes through OrbStack's proxy and 502s, which blanks the
# sign-in page. Adding docker service names to NO_PROXY lets container-to-container traffic bypass the proxy.
function drs() {
  local rails_port="3000"
  if [[ -f .env ]]; then
    local port_value
    port_value=$(grep -E '^COCAM_RAILS_PORT=' .env | tail -n1 | cut -d'=' -f2- | tr -d '"'\''[:space:]')
    [[ -n "$port_value" ]] && rails_port="$port_value"
  fi
  [[ -n "$ZELLIJ" ]] && zellij action rename-pane ":$rails_port"

  # Both spellings: Ruby's net/http reads no_proxy, other clients read NO_PROXY.
  local no_proxy_list="vite,anycable,ws,sidekiq,redis,memcached,postgis,mongo,opensearch,elasticsearch,imgproxy,mailpit,localhost,127.0.0.1,*.orb.internal,*.orb.local"

  # CLEAN_LOGS=1 is passed explicitly rather than inherited from the dip
  # alias: this function is defined above that alias, and zsh expands
  # aliases at parse time, so the body would otherwise call bare dip.
  dip CLEAN_LOGS=1 compose run --rm vite yarn install
  dip CLEAN_LOGS=1 up -d vite
  dip CLEAN_LOGS=1 up -d sidekiq
  dip CLEAN_LOGS=1 NO_PROXY="$no_proxy_list" no_proxy="$no_proxy_list" rails s
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

alias ddrc="CLEAN_LOGS=1 DEBUG_LOGS=true drc"

alias drss="dip up -d vite && dip up rails sidekiq"
alias ddrs="ddip up -d sidekiq vite && ddip rails s"
alias ddrss="ddip up -d vite && ddip up rails sidekiq"

alias dbe="dip bundle exec"
alias ddbe="ddip bundle exec"

alias did="dip down"
