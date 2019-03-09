source $HOME/.dotfiles/bin/os_type.sh

# Homebrew
if [ -d $HOME/homebrew ]; then
  export PATH=$HOME/bin:$HOME/homebrew/bin:$PATH
fi

if is_centos; then
  export NODEJS_HOME=/usr/local/lib/nodejs/node-v10.14.2/bin
  export PATH=$NODEJS_HOME:$PATH
fi

export PATH=$HOME/bin:$PATH

export PATH=$HOME/homebrew/opt/icu4c/bin:$PATH
export PATH=$HOME/homebrew/opt/icu4c/sbin:$PATH
export LDFLAGS="-L$HOME/homebrew/opt/icu4c/lib"
export CPPFLAGS="-I$HOME/homebrew/opt/icu4c/include"

export PATH=$HOME/homebrew/opt/bison/bin:$PATH
export LDFLAGS="-L~/homebrew/opt/bison/lib"
