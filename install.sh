#!/bin/sh

set -e

lowercase(){
  # echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghipqrstuvwxyz/"
  echo "$1" | awk '{print tolower($0)}'
}

OS=`lowercase \`uname\``
KERNEL=`uname -r`
MACH=`uname -m`

if [ "{$OS}" == "windowsnt" ]; then
  OS=windows
elif [ "{$OS}" == "darwin" ]; then
  OS=mac
else
  OS=`uname`
  if [ "${OS}" = "SunOS" ] ; then
    OS=Solaris
    ARCH=`uname -p`
    OSSTR="${OS} ${REV}(${ARCH} `uname -v`)"
  elif [ "${OS}" = "AIX" ] ; then
    OSSTR="${OS} `oslevel` (`oslevel -r`)"
  elif [ "${OS}" = "Linux" ] ; then
    if [ -f /etc/redhat-release ] ; then
      DistroBasedOn='RedHat'
      DIST=`cat /etc/redhat-release |sed s/\ release.*//`
      PSUEDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
      REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
    elif [ -f /etc/SuSE-release ] ; then
      DistroBasedOn='SuSe'
      PSUEDONAME=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
      REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
    elif [ -f /etc/mandrake-release ] ; then
      DistroBasedOn='Mandrake'
      PSUEDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
      REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
    elif [ -f /etc/debian_version ] ; then
      DistroBasedOn='Debian'
      DIST=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
      PSUEDONAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F=  '{ print $2 }'`
      REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }'`
    fi
    if [ -f /etc/UnitedLinux-release ] ; then
      DIST="${DIST}[`cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//`]"
    fi
    OS=`lowercase $OS`
    DistroBasedOn=`lowercase $DistroBasedOn`
    readonly OS            # linux
    readonly DIST          # CentOS
    readonly DistroBasedOn # Redhat
    readonly PSUEDONAME    # Final
    readonly REV           # 6.8
    readonly KERNEL        # 2.6.32-xxx
    readonly MACH          # x86_64
  fi
fi

is_osx(){
  [ OS = Darwin ]
}
  
is_debian(){
  [ DIST = Ubuntu ]
}

is_redhat() {
  [ DistroBasedOn = Redhat ]
}

if is_osx; then
  echo "Installing Homebrew packages..."
  brew update
  brew tap homebrew/bundle
  brew bundle
  for brewfile in */Brewfile; do
    brew bundle --file="$brewfile"
  done
fi

if is_ubuntu; then
  echo "Installing linux packages..."
  sudo apt-get install xclip -y
  sudo add-apt-repository ppa:pgolm/the-silver-searcher
  sudo apt-get update
  sudo apt-get install the-silver-searcher
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
vim +PlugInstall +qa

if [ -d $HOME/.oh-my-zsh ]
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if is_osx; then
  echo
  echo "If you like what you see in system/osx-settings, run ./system/osx-settings"
  echo "If you're using Terminal.app, check out the terminal-themes directory"
fi

if is_linux; then
  ln -sf ~/.dotfiles/system/dircolors.256dark ~/.dircolors.256dark
fi

for setup in tag-*/setup; do
  . "$setup"
done
