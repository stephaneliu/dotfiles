# vim: syntax=ruby filetype=ruby

# Usage:
#   list:
#     * defaults --brews
#     * --all
#     * --mas
#       Mac apps
#     * --casks
#     * --taps
# Versioning is not a feature of brew bundle. Only the latest version is installed

tap 'heroku/brew'
tap 'homebrew/cask'
tap 'homebrew/cask-fonts'
tap 'homebrew/command-not-found'
tap 'homebrew/core'
tap 'homebrew/services' # `brew services restart postgres`, etc
tap 'thoughtbot/formulae'
# don't tap both cask-fonts and caskroom/fonts
# tap "caskroom/fonts"

brew 'asdf'
brew 'autojump'
brew 'bat' # cat with wings = bat (cat with syntax color)
brew 'chruby'
brew 'cmatrix'
brew 'colordiff' # colorful diffs (alias diff='colordiff -u')
brew 'fzf' # Fuzzy finder
brew 'git'
brew 'gitsh'
brew 'gpg'
brew 'heroku/brew/heroku' # The recommended way to use Heroku
brew 'gh' # Fast GitHub client released in 2020
brew 'imagemagick'
brew 'mas' # Mac appstore cli
brew 'neovim'
brew 'opensc' # smart card support
brew 'postgresql@10', restart_service: :changed
brew 'reattach-to-user-namespace'
brew 'ruby-install'
brew 'terminal-notifier' # programatically send messages to notifications
brew 'the_silver_searcher' # a better ack/grep
brew 'thoughtbot/formulae/rcm'
brew 'tmux'
brew 'universal-ctags' # so :Rtags works
brew 'shared-mime-info'
brew 'vim'
brew 'wget'
brew 'yarn'
brew 'zsh'
brew 'zsh-completions'

unless /zsh$/.match?(ENV.fetch('SHELL', ''))
  puts 'To use the Homebrew-installed ZSH:'
  puts '  sudo echo $(brew --prefix)/bin/zsh >> /etc/shells'
  puts '  chsh -s $(brew --prefix)/bin/zsh'
end

# cask 'dropbox'
# cask 'evernote'
# cask "1password"
# cask "google-chrome"
# cask 'firefox'
# cask 'vlc'
# cask "superduper", args: {appdir: "~/Applications"}

# cask "chromium"
cask 'divvy'
# cask 'graphiql'
cask 'font-hack-nerd-font'
cask 'font-jetbrains-mono-nerd-font'
cask 'gpg-suite-no-mail'
cask 'hammerspoon'
cask 'hand-mirror' # utility to see what camera is seeing prior to jumping on video call
# cask 'hocus-focus' # utility auto close unfocused applications - http://hocusfoc.us
cask 'iterm2'
cask 'karabiner-elements'
cask 'keycastr' # dispaly keystrokes for screencasts
cask 'numi'
cask 'obsidian'
# cask "vanilla" # utility to collapse the icons in menubar
# cask "macvim", args: {appdir: "~/Applications"}
# cask "nightowl", args: {appdir: "~/Applications"}

# CLI: mas search [app]
# Returns app name and app id
# mas install [app_id]
mas 'Agenda', id: 1_287_445_660
# mas "DayOne", id: 1055511498
mas 'Spark', id: 1_176_895_641
