alias ann="be annotate -mi -p before"
alias b='bundle'
alias r='bin/rails'
alias be='bundle exec'
alias beg='spring stop && bundle exec guard'
alias bs='bundle show'
alias bu='bundle update'
alias rubo="bundle exec rubocop --auto-correct --format simple"
alias vig="vi Gemfile"
alias dnup="r db:drop && r db:create && r db:migrate && r db:seed"

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
  source $HOME/homebrew/share/chruby/chruby.sh
  source $HOME/homebrew/share/chruby/auto.sh
  chruby ruby
elif [ -f /usr/local/share/chruby/chruby.sh ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  chruby ruby
fi
