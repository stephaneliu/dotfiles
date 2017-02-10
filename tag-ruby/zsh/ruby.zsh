alias ann="annotate -mi -p before"
alias b='bundle'
alias be='bundle exec'
alias bec='bundle exec rails c'
alias beg='spring stop && bundle exec guard'
alias ber='bundle exec rake'
alias bes='bundle exec rails s'
alias bs='bundle show'
alias bu='bundle update'
alias r="rails"
alias rc="rails c"
alias rc="rails c"
alias rg="rails g"
alias rs="rails server"
alias ss="spring stop"

# added by travis gem
[ -f /Users/sliu/.travis/travis.sh ] && source /Users/sliu/.travis/travis.sh

# Useage: 'use jruby' or 'use ruby'
# Uses PROJECT_JRUBY_VERSION and PROJECT_RUBY_VERSION
# to load jruby/ruby
use() {
  source /usr/local/share/chruby/chruby.sh

  if [ "$1" = "jruby" ]; then
    ENV_RB=$PROJECT_JRUBY_VERSION
  else
    ENV_RB=$PROJECT_RUBY_VERSION
  fi

  chruby $ENV_RB
  ruby -v
  # exit 0
}

source /usr/local/share/chruby/chruby.sh
# default ruby
chruby ruby-2.4.0
