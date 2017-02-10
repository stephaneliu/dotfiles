#!/bin/sh

# Exits immediately on error
# set -e # disabled until script is stabilized


. ~/.dotfiles/utils/os_type.sh

if is_osx; then
  echo "Installing Homebrew packages..."
  brew update
  brew tap homebrew/bundle
  brew bundle
  for brewfile in */Brewfile; do
    brew bundle --file="$brewfile"
  done
fi

if is_debian; then
  echo "Installing linux packages..."
  sudo apt-get install xclip -y
  sudo add-apt-repository ppa:pgolm/the-silver-searcher
  sudo apt-get update
  sudo apt-get install the-silver-searcher
fi

if is_centos; then
  echo "Installing yum packages..."
  sudo yum install xclip -y
  sudo yum install autojump-zsh -y
  sudo yum install ctags

  # dependencies for silver searcher
  sudo yum install pcre-devel -y
  sudo yum install xz-devel -y
  cd ~/tmp
  git clone https://github.com/ggreer/the_silver_searcher.git
  cd the_silver_searcher
  ./build.sh
  make
  sudo make install
  which ag
fi

echo "Linking dotfiles into ~..."
# Before `rcup` runs, there is no ~/.rcrc, so we must tell `rcup` where to look.
# We need the rcrc because it tells `rcup` to ignore thousands of useless Vim
# backup files that slow it down significantly.
RCRC=rcrc rcup -v -d .

if [ -d $HOME/.vim/bundle/Vundle.vim ]
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi
echo "Installing Vim packages..."
vim +PluginInstall +qa

if [ -d $HOME/.oh-my-zsh ]
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if is_osx; then
  echo
  echo "If you like what you see in system/osx-settings, run ./system/osx-settings"
  echo "If you're using Terminal.app, check out the terminal-themes directory"
fi

for setup in tag-*/setup; do
  . "$setup"
done
