gem 'haml-rails'
gem 'bootstrap', '~>4.0.0'
gem 'devise'

gem_group :development, :test do
  gem 'better_errors'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'pronto'
  gem 'pronto-rubocop', require: false
  gem 'pronto-flay', require: false
  gem 'pronto-simplecov', require: false
  gem 'pronto-brakeman', require: false
  gem 'pronto-haml', require: false
  gem 'pronto-rails_best_practices', require: false
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
  gem 'rails_layout'
  gem 'spring-commands-rspec'
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

simplecov_setup = <<-EOL
require 'simplecov'

if ENV['COVERAGE'] == 'true'
  SimpleCov.start 'rails' do
    minimum_coverage 90
    maximum_coverage_drop 5
  end
end

EOL

prepend_to_file 'spec/spec_helper.rb', simplecov_setup

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
current_ruby = current_ruby.blank? ?  RUBY_VERSION : current_ruby.chomp
create_file ".ruby-version", "ruby-#{current_ruby}"

# initialize guards
# run 'bundle exec guard init'
guard_setup = <<-EOL
# frozen_string_literal: true

group :red_green_refactor, halt_on_fail: true do
  rspec_options = {
    cmd: 'bin/rspec -f doc',
    run_all: {
      cmd: 'COVERAGE=true bundle exec rspec -f doc'
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
end
EOL

create_file 'Guardfile', guard_setup

run 'bundle exec spring binstub --all'

rails_command 'db:create'

rubocop_config = <<-EOL
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
    - 'Gemfile' - 'config/initializers/devise.rb'
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

create_file 'README'

after_bundle do
  inject_into_file '.gitignore', after: "byebug_history\n" do
<<-EOL
coverage
EOL
  end

  run 'bundle exec rubocop --auto-correct'

  run 'rm -rf test'

  git :init
  git add: '.'
  git commit: '-m "Initial commit."'
end

run 'direnv allow'
