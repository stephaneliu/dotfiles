# vim: syntax=ruby filetype=ruby

# Lets us do `brew services restart postgres`, etc
tap 'homebrew/services'
tap 'thoughtbot/formulae'
tap 'heroku/brew'
tap 'homebrew/cask'
tap 'caskroom/fonts'

# Qt is not registered in DADMS at the moment. Install as needed or use Docker containers
# Qt5.5 for capybara-webkit, because Qt 5.6 doesn't work except with the most recent version
# brew 'qt55'
# --overwrite: overwrite any Qt4 files that might be there
#                          |--force: required because qt55 is keg-only
# `brew link --overwrite --force qt55`

brew 'autojump'
brew 'chruby'
brew 'colordiff' # colorful diffs (alias diff='colordiff -u')
brew 'ctags' # so :Rtags works
brew 'fzf' # Fuzzy finder
brew 'git'
brew 'gpg'
brew 'heroku/brew/heroku' # The recommended way to use Heroku
brew 'hub' # Fast GitHub client
brew 'opensc' # smart card support
brew 'postgresql'
brew 'reattach-to-user-namespace'
# brew 'ripgrep' # Faster grep written in Rust
brew 'ruby-install'
brew 'terminal-notifier' # programatically send messages to notifications
brew 'the_silver_searcher' # a better ack/grep
brew 'thoughtbot/formulae/rcm'
brew 'tmux'
brew 'vim' # It's vim
brew 'zsh'
brew 'zsh-completions'

if ENV.fetch("SHELL", "") != "/$HOME/homebrew/bin/zsh"
  puts "To use the Homebrew-installed ZSH:"
  puts "  sudo echo $HOME/homebrew/bin/zsh >> /etc/shells"
  puts "  chsh -s $HOME/homebrew/bin/zsh"
end

# Cask: install binaries
# cask 'dropbox'
# cask 'evernote'
cask '1password'
cask 'google-chrome'
# cask 'firefox'
# cask 'vlc'
# Keyboard remapping on macOS
cask 'karabiner-elements'
cask 'font-droidsansmono-nerd-font-mono'
cask 'macvim'
cask 'phantomjs'
cask 'divvy'
cask 'superduper'
