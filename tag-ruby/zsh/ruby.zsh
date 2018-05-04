alias ann="be annotate -mi -p before"
alias b='bundle'
alias be='bundle exec'
alias bec='bundle exec rails c'
alias beg="dev_run 'spring stop && bundle exec guard --clear --force-polling'"
alias bo='bundle open'
alias bs='bundle show'
alias bu='bundle update'
alias r="rails"
alias rc="dev_run 'rails c'"
alias rg="dev_run 'rails g'"
alias rs="rails server"
alias ss="spring stop"

dev_run() {
  if dockered; then
    rails_docker_name=$RAILS_DOCKER || 'app'
    docker-compose run $rails_docker_name $1
  else
    eval $1
  fi
}

dockered() {
  if [ -f ${PWD}/Dockerfile ]; then
    return 0
  else
    return 1
  fi
}

# added by travis gem
[ -f ${HOME}/.travis/travis.sh ] && source ${HOME}/.travis/travis.sh

if [ -f /usr/local/share/chruby/chruby.sh ]; then
  source /usr/local/share/chruby/chruby.sh
  chruby ruby
fi

# LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
# if [ -f $LUNCHY_DIR/lunchy-completion.zsh ]; then
#   . $LUNCHY_DIR/lunchy-completion.zsh
# else
#   echo 'Lunchy not installed - gem install lunchy'
# fi

# source $HOME/bin/ruby_switcher.sh
