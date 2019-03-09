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

tap "heroku/brew"
tap "homebrew/cask"
tap "homebrew/cask-fonts"
tap "homebrew/core"
tap "homebrew/services"                      # `brew services restart postgres`, etc
tap "thoughtbot/formulae"
tap "caskroom/fonts"

brew "autojump"
brew "chruby"
brew "colordiff"                             # colorful diffs (alias diff='colordiff -u')
brew "ctags"                                 # so :Rtags works
brew "fzf"                                   # Fuzzy finder
brew "git"
brew "gpg"
brew "heroku/brew/heroku"                    # The recommended way to use Heroku
brew "hub"                                   # Fast GitHub client
brew "mas"                                   # Mac appstore cli
brew "macvim"
brew "mysql", restart_service: true
brew "opensc"                                # smart card support
brew "postgresql", restart_service: :changed
brew "reattach-to-user-namespace"
brew "ruby-install"
brew "terminal-notifier"                     # programatically send messages to notifications
brew "the_silver_searcher"                   # a better ack/grep
brew "thoughtbot/formulae/rcm"
brew "tmux"
brew "yarn"
brew "zsh"
brew "zsh-completions"

unless /zsh$/.match?(ENV.fetch("SHELL", ""))
  puts "To use the Homebrew-installed ZSH:"
  puts "  sudo echo $HOME/homebrew/bin/zsh >> /etc/shells"
  puts "  chsh -s $HOME/homebrew/bin/zsh"
end

# cask 'dropbox'
# cask 'evernote'
# cask "1password"
# cask "google-chrome"
# cask 'firefox'
# cask 'vlc'
# cask "superduper", args: {appdir: "~/Applications"}

casK "chromium", args: {appdir: "~/Applications"}
cask "divvy", args: {appdir: "~/Applications"}
cask "docker", args: {appdir: "~/Applications"}
cask "font-droidsansmono-nerd-font-mono"
cask "font-hack-nerd-font"
cask "karabiner-elements"
# cask "macvim", args: {appdir: "~/Applications"}
# cask "nightowl", args: {appdir: "~/Applications"}
