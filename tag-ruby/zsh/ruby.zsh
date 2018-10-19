alias ann="be annotate -mi -p before"
alias b='bundle'
alias be='bundle exec'
alias bec='bundle exec rails c'
alias beg="dev_run 'spring stop && bundle exec guard --clear'" 
alias bo='bundle open'
alias bs='bundle show'
alias bu='bundle update'
alias r="bin/rails"
alias rc='bin/rails c'
alias rg='bin/rails g'
alias rs="bin/rails server"
alias ss="spring stop"
alias vig="vi Gemfile"

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
fi

# LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
# if [ -f $LUNCHY_DIR/lunchy-completion.zsh ]; then
#   . $LUNCHY_DIR/lunchy-completion.zsh
# else
#   echo 'Lunchy not installed - gem install lunchy'
# fi

# source $HOME/bin/ruby_switcher.sh
