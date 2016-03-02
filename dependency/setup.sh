
echo "Install library dependencies before proceeding"

platform=`uname`

if [ -d !$HOME/tmp ]
then
  mkdir -p $HOME/tmp
fi

# Brew depends on ruby
command -v chruby
if [ $? -eq 0 ]
then
  echo "OK - chruby already installed"
else
  echo "Installing chruby"
  curl -faSL https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz > ~/tmp/chruby-0.3.9.tar.gz
  cd $HOME/tmp
  tar -xzvf chruby-0.3.9.tar.gz
  cd chruby-0.3.9/
  sudo make install
  cd -
fi

if [[ "$platform" == "Darwin" ]]
then 
  command -v brew
  if [ $? -eq  0 ]
  then
    echo "OK - brew already installed"
  else
    echo "Installing brew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Reloading current session"
    if [ -e ~/.zshrc]
    then
      source $HOME/.zshrc
    else
      source $HOME/.bashrc
    fi
  fi

  echo "Install ruby-install"
  brew install ruby-install

  echo "Installing wget"
  brew install wget

  echo "Installing direnv"
  brew install direnv
else
  echo "Dependency requirements for linux platforms comming soon..."
fi
