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
tap 'cooklang/tap'

brew 'asdf'
brew 'autojump'
brew 'bat'                         # cat with wings = bat (cat with syntax color) - https://github.com/sharkdp/bat
brew 'chruby'
brew 'cmatrix'
brew 'colordiff'                   # colorful diffs (alias diff='colordiff -u')
brew 'cooklang/tap/cook'
brew 'ctop'                        # Top-like interface for docker container metrics
brew 'duf'                         # Better Unix: better duf - https://github.com/muesli/duf
brew 'dust'                        # Better Unix: better du - https://github.com/bootandy/dust
brew 'fzf'                         # Fuzzy finder
brew 'git'
brew 'git-delta'                   # Syntax highlighter for git, diff, & grep - https://github.com/dandavison/delta
brew 'gitsh'
brew 'gpg'
brew 'heroku/brew/heroku'          # The recommended way to use Heroku
brew 'gh'                          # Fast GitHub client released in 2020
brew 'jq'                          # Lightweight and flexible command-line JSON processor
brew 'imagemagick'                 # Dependency for Lolcommits
brew 'libpq'
brew 'lsd'                         # Better Unix: better ls
brew 'mas'                         # Mac appstore cli
brew 'neovim'
brew 'procs'                       # Better unix: better ps
brew 'reattach-to-user-namespace'
brew 'ripgrep'
brew 'ruby-install'
brew 'terminal-notifier'           # programatically send messages to notifications
brew 'the_silver_searcher'         # a better ack/grep
brew 'thoughtbot/formulae/rcm'
brew 'tldr'                        # man pages implemented in rust - `tldr ssh`
brew 'tmux'
brew 'universal-ctags'             # so :Rtags works
brew 'shared-mime-info'
brew 'vim'
brew 'wget'
brew 'yarn'
brew 'zsh'
brew 'zsh-completions'

# brew 'opensc'                                                                  # smart card support
#
unless /zsh$/.match?(ENV.fetch('SHELL', ''))
  puts 'To use the Homebrew-installed ZSH:'
  puts '  sudo echo $(brew --prefix)/bin/zsh >> /etc/shells'
  puts '  chsh -s $(brew --prefix)/bin/zsh'
end

cask '1password' unless system 'ls /Applications/1Password*'
cask 'alfred' unless system 'ls /Applications/Alfred*'
cask 'app-cleaner'
cask 'rocket' unless system 'ls /Applications/Rocket*'
cask 'cron' unless system 'ls /Applications/Cron*'
cask 'font-hack-nerd-font'
cask 'font-jetbrains-mono-nerd-font'
cask 'gpg-suite-no-mail'
cask 'hammerspoon'
# cask 'hocus-focus' # utility auto close unfocused applications - http://hocusfoc.us
cask 'iterm2'
cask 'karabiner-elements'
cask 'keycastr' # dispaly keystrokes for screencasts
cask 'numi'
cask 'obsidian' unless system 'ls /Applications/Obsidian.app'
cask 'pushplaylabs-sidekick' unless system 'ls /Applications/Sidekick.app'
cask 'unclack' # unless system 'ls /Application/Unclack.app' # https://unclack.app/#/

# CLI: mas search [app]
# Returns app name and app id
# mas install [app_id]
mas 'Agenda', id: 1_287_445_660
mas 'Spark', id: 1_176_895_641
mas 'Hand Mirror', id: 1_502_839_586
