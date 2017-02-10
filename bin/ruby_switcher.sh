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
}
