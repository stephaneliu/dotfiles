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

tap 'homebrew/cask'
tap 'buo/cask-upgrade' # Fix cask upgrade when exists
tap 'homebrew/cask-fonts'
tap 'homebrew/command-not-found'
tap 'homebrew/core'
tap 'homebrew/services' # `brew services restart postgres`, etc
tap 'thoughtbot/formulae'
tap 'cooklang/tap'
tap 'jdxcode/tap'

brew 'autojump'
brew 'bat'                         # cat with wings = bat (cat with syntax color) - https://github.com/sharkdp/bat
brew 'cheat'                       # Terminal cheatsheets - https://github.com/cheat/cheat
brew 'chruby'
brew 'cmake'                       # Ruby native extensions
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
brew 'gh'                          # Fast GitHub client released in 2022
brew 'helix'
brew 'jq'                          # Lightweight and flexible command-line JSON processor
brew 'imagemagick'                 # Dependency for Lolcommits
brew 'libpq'
brew 'lsd'                         # Better Unix: better ls
brew 'mas'                         # Mac appstore cli
brew 'neovim'
brew 'pkg-config'                  # Ruby native extensions
brew 'procs'                       # Better unix: better ps
brew 'reattach-to-user-namespace'
brew 'ripgrep'
brew 'rtx'                         # asdf written in Rust. No shims
brew 'ruby-install'
brew 'terminal-notifier'           # programatically send messages to notifications
brew 'the_silver_searcher'         # a better ack/grep
brew 'thoughtbot/formulae/rcm'
brew 'tldr'                        # man pages implemented in rust - `tldr ssh`
brew 'tmux'
brew 'tmuxinator-completion'
brew 'universal-ctags'             # so :Rtags works
brew 'shared-mime-info'
brew 'viddy'                       # watch [process] https://github.com/sachaos/viddy
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

cask '1password'
cask 'app-cleaner' unless system 'ls /Applications/AppCleaner*' # Version is free legacy
cask 'cron'
cask 'dash'
cask 'divvy'
cask 'docker'
cask 'font-hack-nerd-font'
cask 'font-jetbrains-mono-nerd-font'
cask 'gpg-suite-no-mail'
cask 'graphiql'
cask 'kap'
cask 'kitty'
cask 'raycast'
cask 'readdle-spark'
cask 'rocket'
cask 'tailscale'
cask 'karabiner-elements'
cask 'keycastr' # dispaly keystrokes for screencasts
cask 'numi'
cask 'pushplaylabs-sidekick'
cask 'ultimaker-cura'

# CLI: mas search [app]
# Returns app name and app id
# mas install [app_id]
mas 'Craft - Docs and Notes Editor', id: 1_487_937_127
mas 'Hand Mirror', id: 1_502_839_586
mas 'Magnet', id: 441_258_766
mas 'Marked 2', id: 890_031_187
