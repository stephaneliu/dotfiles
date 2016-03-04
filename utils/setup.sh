echo "# Configuring utilities"

platform=`uname`

if [[ "$platform" == "Darwin" ]]
then 
  echo "Installing ctags"
  brew install ctags

  echo "Installing the_silver_searcher"
  brew install the_silver_searcher

  echo "Installing zsh"
  brew install zsh

  echo "Installing git"
  brew install git

  echo "installing reattach-to-user-namespace (copy/paste in tmux to mac buffer)"
  brew install reattach-to-user-namespace

  echo "Installing mysql"
  brew install mysql
fi

if [[ "$platform" == "Linux" ]]
then
  echo "Installing exuberant tags"
  sudo apt-get install exuberant-ctags

  echo "Installing the_silver_searcher"
  sudo apt-get install silversearcher-ag

  echo "Install zsh"
  sudo apt-get install zsh

  echo "Installing git"
  sudo apt-get install git

  echo "Need to install reattach-to-user-namespace manually"
fi
