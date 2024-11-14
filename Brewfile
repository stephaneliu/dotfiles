# vim: syntax=ruby filetype=ruby

# Usage:
#   bundle list:
#     * defaults --brews
#     * --all
#     * --mas
#       Mac apps
#     * --casks
#     * --taps
#   bundle dump: Inventory of installed brews
# Versioning is not a feature of brew bundle. Only the latest version is installed

tap 'buo/cask-upgrade' # Fix cask upgrade when exists
tap 'heroku/brew'
tap 'homebrew/command-not-found'
tap 'homebrew/services' # `brew services restart postgres`, etc
tap 'jdxcode/tap'

brew 'autojump'
brew 'bat'                         # cat with wings = bat (cat with syntax color) - https://github.com/sharkdp/bat
brew 'cheat'                       # Terminal cheatsheets - https://github.com/cheat/cheat
brew 'cmake'                       # Ruby native extensions
brew 'cmatrix'
brew 'colordiff'                   # colorful diffs (alias diff='colordiff -u')
brew 'coreutils'                   # used for gnu coreutils i.e - tac
brew 'ctop'                        # Top-like interface for docker container metrics
brew 'direnv'
brew 'duf'                         # Better Unix: better duf - https://github.com/muesli/duf
brew 'dust'                        # Better Unix: better du - https://github.com/bootandy/dust
brew 'fzf'                         # Fuzzy finder
brew 'git'
brew 'git-delta'                   # Syntax highlighter for git, diff, & grep - https://github.com/dandavison/delta
brew 'gpg'
brew 'gh'                          # Fast GitHub client released in 2022
brew 'helix'
brew 'heroku'
brew 'jq'                          # Lightweight and flexible command-line JSON processor
brew 'imagemagick'                 # Dependency for Lolcommits
brew 'libexif'                     # Depencency for CC API repo
brew 'libpq'                       # pg client https://formulae.brew.sh/formula/libpq
brew 'lnav'                        # Log file navigator - https://lnav.org/
brew 'lsd'                         # Better Unix: better ls
brew 'mas'                         # Mac appstore cli
brew 'mdcat'                       # View markdown in kitty - `mdcat README.md`
brew 'neovim'
brew 'postgresql@14'
brew 'pkg-config'                  # Ruby native extensions
brew 'procs'                       # Better unix: better ps - https://github.com/dalance/procs
brew 'reattach-to-user-namespace'
brew 'ripgrep'
brew 'mise'                         # asdf written in Rust. No shims
# brew 'ruby-install'
brew 'tailspin'
brew 'terminal-notifier'           # programatically send messages to notifications
brew 'the_silver_searcher'         # a better ack/grep
brew 'rcm'
brew 'sniffnet'                    # sniff network traffic - https://github.com/GyulyVGC/sniffnet
brew 'tldr'                        # man pages implemented in rust - `tldr ssh`
# brew 'universal-ctags'             # so :Rtags works
brew 'shared-mime-info'
brew 'viddy'                       # watch [process] https://github.com/sachaos/viddy
brew 'wget'
brew 'yarn'
brew 'zsh'
brew 'zsh-completions'
brew 'zsh-vi-mode' # https://github.com/jeffreytse/zsh-vi-mode

cask '1password' unless system 'ls /Applications/1Password*'
cask '1password-cli' # 1password cli - https://developer.1password.com/docs/cli/get-started/
cask 'app-cleaner' unless system 'ls /Applications/AppCleaner*' # Version is free legacy
cask 'bruno'     # api explorer
cask 'craft'
cask 'dash'
cask 'devtoys'
cask 'divvy'
cask 'docker'
cask 'font-hack-nerd-font'
cask 'font-jetbrains-mono-nerd-font'
cask 'gpg-suite-no-mail'
# cask 'insta360-studio'
cask 'ngrok'
cask 'kap'
cask 'kitty'
cask 'polypane'
cask 'raycast'
cask 'readdle-spark'
cask 'reflect'
cask 'tailscale'
cask 'there'
cask 'karabiner-elements'
cask 'keycastr' # dispaly keystrokes for screencasts
cask 'numi'
cask 'pieces'
cask 'pushplaylabs-sidekick'
cask 'send-to-kindle'
cask 'xnapper' unless system 'ls /Applications/Xnapper*'
# cask 'ultimaker-cura'

# CLI: mas search [app]
# Returns app name and app id
# mas install [app_id]
mas "Fantastical", id: 975937182
mas "Monodraw", id: 920404675
mas "Tailscale", id: 1475387142
mas "Things", id: 904280696
mas 'Hand Mirror', id: 1_502_839_586
mas 'Marked 2', id: 890_031_187
