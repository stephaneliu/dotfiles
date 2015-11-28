echo "# Configuring utilities"

platform=`uname`

if [ "$platform" == "Darwin" ]
then 
  # Install Homebrew
  which brew
  if [ $? == 0 ]
  then
    echo "brew installed"
  else
    echo "Installing brew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "Installing ctags"
  brew install ctags

  echo "Installing the_silver_searcher"
  brew install the_silver_searcher

  echo "Installing zsh"
  brew install zsh

  echo "Install git"
  brew install git
fi

if [ "$platform" == "Linux" ]
then
  echo "Installing exuberant tags"
  sudo apt-get install exuberant-ctags

  echo "Installing the_silver_searcher"
  apt-get install silversearcher-ag
fi
