# vim: syntax=ruby filetype=ruby

# Lets us do `brew services restart postgres`, etc
tap 'homebrew/services'
# Old versions of some packages
tap 'homebrew/versions'
# Qt5.5 for capybara-webkit, because Qt 5.6 doesn't work except with the most
# recent version
brew 'qt55'
# --overwrite: overwrite any Qt4 files that might be there
# --force: required because qt55 is keg-only
`brew link --overwrite --force qt55`
# The recommended way to use Heroku
brew 'heroku'
brew 'chruby'
brew 'ruby-install'
# colorful diffs (alias diff='colordiff -u')
brew 'colordiff'
# a better ack/grep
brew 'the_silver_searcher'
brew 'direnv'
# so :Rtags works
brew 'ctags'
# It's vim
brew 'vim'
# Used in Rails projects
brew 'phantomjs'
# Fast GitHub client
brew 'hub'
# Fuzzy finder
brew 'fzf'
tap 'thoughtbot/formulae'
brew 'thoughtbot/formulae/rcm'
brew 'autojump'
brew 'mysql'

# Install zsh 5.2+ (OS X ships with 5.0) to fix this issue:
# https://github.com/robbyrussell/oh-my-zsh/issues/4932
brew 'zsh'

if ENV.fetch("SHELL", "") != "/usr/local/bin/zsh"
  puts "To use the Homebrew-installed ZSH:"
  puts "  sudo echo /usr/local/bin/zsh >> /etc/shells"
  puts "  chsh -s /usr/local/bin/zsh"
end

# Cask: install binaries
# cask 'alfred'
cask 'dropbox'
cask 'evernote'
cask '1password'
cask 'google-chrome'
cask 'firefox'
# cask 'vlc'
# Keyboard remapping on macOS
cask 'karabiner-elements'
cask 'font-droid-sans-mono'
