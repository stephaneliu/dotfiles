alias ann="be annotate -mi -p before"
alias b='bundle'
alias r='bin/rails'
alias rc='bin/rails c'
alias rs='bin/rails s'
alias rg='bin/rails generate'
alias be='bundle exec'
alias beg='spring stop && bundle exec guard'
alias bi='bundle info'
alias bu='bundle update'
alias rubo="bundle exec rubocop --auto-correct --format simple"
alias pspec="bin/pspec"
alias vig="vi Gemfile"
alias dnup="bin/rails db:drop && bin/rails db:create && bin/rails prepare"

dev_run() {
  if dockered && ! in_docker; then
    rails_docker_name=$RAILS_DOCKER || 'app'
    docker-compose run $rails_docker_name $1
  else
    eval $1
  fi
}

dockered() {
  [ -f ${PWD}/Dockerfile ]
}

in_docker() {
  [ -f /.dockerenv ]
}

# added by travis gem
[ -f ${HOME}/.travis/travis.sh ] && source ${HOME}/.travis/travis.sh

if [ -f $HOME/homebrew/share/chruby/chruby.sh ]; then
  RUBIES+=(
    "$HOME/.rubies"
  )
  source $HOME/homebrew/share/chruby/chruby.sh
  source $HOME/homebrew/share/chruby/auto.sh
  chruby ruby
elif [ -f /usr/local/share/chruby/chruby.sh ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  chruby ruby
fi
