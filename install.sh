#!/bin/sh

# Exits immediately on error
# set -e # disabled until script is stabilized
install_dir=$PWD
unset GIT_SSL_CERT 

source $HOME/.dotfiles/bin/os_type.sh

if is_osx; then
  if [ ! `command -v $HOME/homebrew/bin/brew` ]; then
    echo "Installing Homebrew in $HOME/homebrew"
    cd $HOME
    mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | \
      tar xz --strip 1 -C homebrew
  fi

  echo "Installing Homebrew packages"
  $HOME/homebrew/bin/brew update
  $HOME/homebrew/bin/brew tap homebrew/bundle
  $HOME/homebrew/bin/brew bundle
  for brewfile in */Brewfile; do
    $HOME/hombrew/bin/brew bundle --file="$brewfile"
  done
fi

export PATH=$HOME/homebrew/bin:$PATH

if is_debian; then
  echo "Installing linux packages"
  sudo add-apt-repository ppa:pgolm/the-silver-searcher
  sudo apt-get update
  sudo apt-get install xclip -y
  sudo apt-get install the-silver-searcher -y
fi

if is_redhat || is_centos; then
  echo "Installing yum packages"
  sudo yum -q -y install xclip
  sudo yum -q -y install autojump-zsh
  sudo yum -q -y install ctags
  sudo yum -q -y install zsh 

  # dependencies for silver searcher
  sudo yum -q -y install pcre-devel
  sudo yum -q -y install xz-devel

  if [ ! `command -v ag` ]; then
    cd /tmp
    git clone https://github.com/ggreer/the_silver_searcher.git silver_searcher
    cd silver_searcher
    ./build.sh
    make
    sudo make install
  else
    echo "The Silver Search is already installed...skipping"
  fi

  umask 022

cd /tmp
curl -LO https://thoughtbot.github.io/rcm/dist/rcm-1.3.3.tar.gz && \
sha=$(sha256sum rcm-1.3.3.tar.gz | cut -f1 -d' ') && \
[ "$sha" = "935524456f2291afa36ef815e68f1ab4a37a4ed6f0f144b7de7fb270733e13af" ] && \
tar -xvf rcm-1.3.3.tar.gz && \
cd rcm-1.3.3 && \
./configure && \
make && \
sudo make install

  if [ ! `command -v rcup` ]; then
    cd /tmp
    curl -LO https://thoughtbot.github.io/rcm/dist/rcm-1.3.3.tar.gz && \
    sha=$(sha256sum rcm-1.3.3.tar.gz | cut -f1 -d' ') && \
    [ "$sha" = "935524456f2291afa36ef815e68f1ab4a37a4ed6f0f144b7de7fb270733e13af" ] && \
    tar -xvf rcm-1.3.3.tar.gz && \
    cd rcm-1.3.3 && \
    ./configure && \
    make && \
    sudo make install
  fi
fi

# Before `rcup` runs, there is no ~/.rcrc, so we must tell `rcup` where to look.
# We need the rcrc because it tells `rcup` to ignore thousands of useless Vim
# backup files that slow it down significantly.
# Pass -v flag to run with verbose
cd $HOME

echo "Linking dotfiles into $HOME"
RCRC=$HOME/.dotfiles/rcrc rcup -f

if [ ! -d $HOME/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

echo "Installing Vim packages"
vim +PluginInstall +qa

cd $HOME

if [ -d $HOME/.oh-my-zsh ]; then
  echo "Oh-my-zsh already installed"
else
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  echo "If changing shell (chsh) to zsh failed, sudo bash then 'chsh -s /bin/zsh {user}'"
fi

cd ${install_dir}

for setup in tag-*/setup; do
  . "$setup"
done

if [ ! -d $HOME/tmp ]; then
  echo "Creating a tmp folder in $HOME"
  mkdir $HOME/tmp
fi

if is_osx; then
  echo
  echo "If you like what you see in system/osx-settings, run ./system/osx-settings"
  echo "If you're using Terminal.app, check out the terminal-themes directory"
fi

echo "Done!"

