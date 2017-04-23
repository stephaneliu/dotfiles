alias ann="be annotate -mi -p before"
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

source /usr/local/share/chruby/chruby.sh
chruby ruby-2.4.1

source $HOME/bin/ruby_switcher.sh
