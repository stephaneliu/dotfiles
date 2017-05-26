gem 'haml-rails'
gem 'bootstrap', '~> 4.0.0.alpha3.1'
gem 'devise', github: 'plataformatec/devise' # look for release > 4.2.1 for rails 5.1 compat

gem_group :development, :test do
  gem 'better_errors'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop'
end

gem_group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'html2haml'
  gem 'hub'
  gem 'listen'
  gem 'meta_request' # rails log in Chrome
  gem 'rb-fsevent', require: false
  gem 'rb-fchange', require: false
  gem 'rb-inotify', require: false
  gem 'rails_layout'
  gem 'terminal-notifier-guard'
end

gem_group :test do
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
end

run 'bundle install'

# setup rspec
generate 'rspec:install'
generate 'devise:install'
generate 'annotate:install'

envrc = <<-EOL
RED='\\033[0;31m'
NC='\\033[0m'
WHITE='\\033[1;37m'
CYAN='\\033[0;36m'

export ENABLE_LIVE_RELOAD=true
export PROJECT_RUBY_VERSION=`cat ./.ruby-version`

printf \"${WHITE}Setting ${PURPLE}APP_CODE${NC} to ${BLUE}$APP_CODE${NC}\\n\"
source /usr/local/share/chruby/chruby.sh && chruby $PROJECT_RUBY_VERSION
if [ $? != 0 ]; then
  printf \"${WHITE}######## ${RED}Houston, we've got a problem...$PROJECT_RUBY_VERSION UNKNOWN ${WHITE}########${NC}\\n\"
else
  printf \"${WHITE}Ruby changed to ${CYAN}$PROJECT_RUBY_VERSION${NC}\\n\"
fi

PATH_add bin
EOL

create_file ".envrc", envrc

# Setup shoulda matchers
shoulda_matchers = <<-EOL
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
EOL

create_file "spec/support/shoulda_matchers.rb", shoulda_matchers

current_ruby = ask("Which ruby version? [#{RUBY_VERSION}]")
current_ruby = current_ruby.blank? ?  RUBY_VERSION : current_ruby
create_file ".ruby-version", "ruby-#{current_ruby}"

# initialize guards
run 'bundle exec guard init'
run 'bundle exec guard init rspec'
run 'bundle exec guard init rubocop'
# TODO: add default rubocop settings

run "git add . && git ci -m 'initial commit'"
