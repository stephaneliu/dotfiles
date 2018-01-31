gem 'devise'
gem 'bootstrap', '~>4.0.0'
gem 'haml-rails'
gem 'pg'
gem 'rack-timeout'

gem_group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'foreman'
  gem 'guard'
  gem 'guard-brakeman', require: false
  gem 'guard-reek'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'html2haml'
  gem 'hub'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'meta_request'
  gem 'pronto'
  gem 'pronto-brakeman', require: false
  gem 'pronto-haml', require: false
  gem 'pronto-reek', require: false
  gem 'pronto-rubocop', require: false
  gem 'pronto-simplecov', require: false
  gem 'rails_layout'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'terminal-notifier'
  gem 'terminal-notifier-guard'
  gem 'web-console', '>= 3.3.0'
end

gem_group :test do
  gem 'capybara', '~> 2.13'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec_junit_formatter'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver' # system test using selenium_chrome_headless
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
  gem 'simplecov'
end

run 'bundle install'

# setup rspec
generate 'rspec:install'
generate 'devise:install'
generate 'annotate:install'

pronto_config = <<-EOL
verbose: false
EOL
create_file ".pronto.yml"

simplecov_config = <<-EOL
require 'simplecov'

if ENV['COVERAGE'] == 'true'
  SimpleCov.start 'rails' do
    minimum_coverage 90
    maximum_coverage_drop 5

    add_filter do |source|
      source.lines.count < 8
    end
  end
end

EOL
prepend_to_file 'spec/spec_helper.rb', simplecov_config

reek_config = <<-EOL
"app/controllers":
  IrresponsibleModule:
    enabled: false
  NestedIterators:
    max_allowed_nesting: 2
  UnusedPrivateMethod:
    enabled: false
  InstanceVariableAssumption:
    enabled: false
"app/helpers":
  IrresponsibleModule:
    enabled: false
  UtilityFunction:
    enabled: false
"app/mailers":
  InstanceVariableAssumption:
    enabled: false
EOL
create_file ".reek", reek_config

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

rack_timeout_config = <<-EOL
# frozen_string_literal: true

# In absence of callback from Heroku router to
# notify Puma of request timeout, set a manual timeout per request
Rack::Timeout.timeout = 20 # seconds
EOL
create_file 'config/initializers/timeout.rb', rack_timeout_config

procfile = <<-EOL
web: bundle exec puma -C config/puma.rb
EOL
create_file 'Procfile', procfile

puma_config = <<-EOL
# frozen_string_literal: true

workers_count = Integer(ENV.fetch('WEB_CONCURRENCY') { 2 })
threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }

workers workers_count
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV.fetch('PORT')      { 3000 }
environment ENV.fetch('RAILS_ENV') { 'development' }

on_worker_boot do
  ActiveRecord::Base.establish_connection
end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
EOL
remove_file 'config/puma.rb'
create_file 'config/puma.rb', puma_config

env = <<-EOL
RACK_ENV=development
PORT=3000
PGUSER=#{ENV['USER']}
EOL
create_file '.env', env

create_file ".ruby-version", "ruby-#{RUBY_VERSION}"

append_to_file 'Gemfile' do
<<-EOL

"ruby '#{RUBY_VERSION}'"
EOL
end

guard_setup = <<-EOL
# frozen_string_literal: true

group :red_green_refactor, halt_on_fail: true do
  rspec_options = {
    cmd: 'bin/rspec -f doc',
    run_all: {
      cmd: 'COVERAGE=true bin/rspec -f doc'
    },
    all_after_pass: true
  }

  guard :rspec, rspec_options do
    require "guard/rspec/dsl"
    dsl = Guard::RSpec::Dsl.new(self)

    # RSpec files
    rspec = dsl.rspec

    watch(rspec.spec_helper)  { rspec.spec_dir }
    watch(rspec.spec_support) { rspec.spec_dir }
    watch(rspec.spec_files)

    # Ruby files
    ruby = dsl.ruby

    dsl.watch_spec_files_for(ruby.lib_files)

    # Rails files
    rails = dsl.rails(view_extensions: %w(erb haml slim))
    dsl.watch_spec_files_for(rails.app_files)
    dsl.watch_spec_files_for(rails.views)

    watch(rails.controllers) do |m|
      [
        rspec.spec.call("routing/\#{m[1]}_routing"),
        rspec.spec.call("controllers/\#{m[1]}_controller"),
        rspec.spec.call("acceptance/\#{m[1]}")
      ]
    end

    # Rails config changes
    watch(rails.spec_helper)    { rspec.spec_dir }
    watch(rails.routes)         { "\#{rspec.spec_dir}/routing" }
    watch(rails.app_controller) { "\#{rspec.spec_dir}/controllers" }

    # Capybara features specs
    watch(rails.view_dirs) { |m| rspec.spec.call("features/\#{m[1]}") }
    watch(rails.layouts)   { |m| rspec.spec.call("features/\#{m[1]}") }

    # Turnip features and steps
    watch(%r{^spec/acceptance/(.+)\.feature$})
    watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
      Dir[File.join("**/\#{m[1]}.feature")][0] || "spec/acceptance"
    end
  end

  rubocop_options = {
    all_on_start: false,
    cli: '--rails --parallel',
    # keep_failed: true,
  }

  guard :rubocop, rubocop_options do
    watch(%r{.+\.rb$})
    watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
  end

  brakeman_options = {
    run_on_start: true,
    quiet: true
  }

  guard 'brakeman', brakeman_options do
    watch(%r{^app/.+\.(erb|haml|rhtml|rb)$})
    watch(%r{^config/.+\.rb$})
    watch(%r{^lib/.+\.rb$})
    watch('Gemfile')
  end
end
EOL

create_file 'Guardfile', guard_setup

run 'bundle exec spring binstub --all'

append_to_file '.gitignore' do
<<-EOL
./coverage
./.env
EOL
end

rails_command 'db:create'

rubocop_config = <<-EOL
AllCops:
  Exclude:
    - 'db/schema.rb'
Metrics/BlockLength:
  Exclude:
    - 'Guardfile'

Style/Documentation:
  Exclude:
    - 'spec/**/*'
    - 'test/**/*'
    - 'app/controllers/application_controller.rb'
    - 'app/helpers/application_helper.rb'
    - 'app/mailers/application_mailer.rb'
    - 'app/models/application_record.rb'
    - 'config/application.rb'

Metrics/BlockLength:
  Exclude:
    - 'Guardfile'
    - 'lib/tasks/auto_annotate_models.rake'

Metrics/LineLength:
  Exclude:
    - 'Gemfile'
    - 'config/initializers/devise.rb'
  Max: 100

Style/MixinUsage:
  Exclude:
    - 'bin/setup'
    - 'bin/update'

Style/PercentLiteralDelimiters:
  Exclude:
    - 'Guardfile'

Style/RegexpLiteral:
  Exclude:
    - 'Guardfile'

Style/StringLiterals:
  Exclude:
    - 'Guardfile'
EOL
create_file ".rubocop.yml", rubocop_config

circleci_config = <<-EOL
# Ruby CircleCI 2.0 configuration file
# Check https://circleci.com/docs/2.0/language-ruby/ for more details

version: 2
jobs:
  build:
    docker:
      # specify the version you desire here
      - image: circleci/ruby:2.4.1-node-browsers
        environment:
          PG_HOST: localhost
          PGUSER: #{app_name}
          RAILS_ENV: test
      - image: circleci/postgres:9.5-alpine
        environment:  
          POSTGRES_USER: #{app_name}
          POSTGRES_DB: #{app_name}_test
          POSTGRES_PASSWORD: ''

    working_directory: ~/#{app_name}

    steps:
      - checkout

      # Download and cache dependencies
      - restore_cache:
          keys:
            - v1-dependencies-{{ checksum "Gemfile.lock" }}
            # fallback to using the latest cache if no exact match is found
            - v1-dependencies-

      - run:
          name: install dependencies
          command: |
            bundle install --without=development --jobs=4 --retry=3 --path vendor/bundle

      - save_cache:
          paths: 
            - ./vendor/bundle
          key: v1-dependencies-{{ checksum "Gemfile.lock" }}

      # Wait for DB
      - run: dockerize -wait tcp://localhost:5432 -timeout 1m

      # Database setup
      - run: bundle exec rake db:create 
      - run: bundle exec rake db:schema:load

      # run tests!
      - run: 
          name: run tests
          command: | 
            mkdir /tmp/test-results
            TEST_FILES="$(circleci tests glob "spec/**/*_spec.rb" | circleci tests split --split-by=timings)"
    
            bundle exec rspec \\
              --format progress \\
              --format RspecJunitFormatter \\
              --out tmp/test-results/rspec.xml \\
              $TEST_FILES

      # collect reports
      - store_test_results:
          path: /tmp/test-results
      - store_artifacts:
          path: /tmp/test-results
          destination: test-results
EOL
create_file '.circleci/config.yml', circleci_config

create_file 'README'

run 'bundle exec rubocop --auto-correct'

git :init
git add: '.'
git commit: '-m "Initial commit."'

run 'direnv allow'

run 'spring stop'
generate 'controller welcome'

welcome = <<-EOL
%h1 Welcome
%p
  Time now
  = Time.now
  to strike, while the iron is hot
EOL
create_file 'app/views/welcome/index.html.haml', welcome

route = <<-EOL
# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
end
EOL
remove_file 'config/routes.rb'
create_file 'config/routes.rb', route

database_config = <<-EOL
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: #{app_name}_development

test:
  <<: *default
  database: notonline_test
  host: <%= ENV.fetch("PGHOST") { "localhost" } %>
  username: <%= ENV.fetch("PGUSER") { ENV["USER"] } %>

# As with config/secrets.yml, you never want to store sensitive information,
# like your database password, in your source code. If your source code is
# ever seen by anyone, they now have access to your database.
#
# Instead, provide the password as a unix environment variable when you boot
# the app. Read http://guides.rubyonrails.org/configuring.html#configuring-a-database
# for a full rundown on how to provide these environment variables in a
# production deployment.
#
# On Heroku and other platform providers, you may have a full connection URL
# available as an environment variable. For example:
#
#   DATABASE_URL="mysql2://myuser:mypass@localhost/somedatabase"
#
# You can use this database configuration with:
#
#   production:
#     url: <%= ENV['DATABASE_URL'] %>
#
production:
  <<: *default
  database: notonline_production
  password: <%= ENV['#{app_name}_DATABASE_PASSWORD'] %>
EOL
remove_file 'config/database.yml'
create_file 'config/database.yml', database_config

git add: '.'
git commit: '-m "Add welcome"'

if yes?("Create new heroku instance?")
  project_name = ask("Name of heroku project?")
  run "heroku create #{project_name}"
  git push: 'heroku master'
  run 'heroku ps:scale web=1' # free tier
  run 'heroku open'
end
run 'bundle exec rubocop'
