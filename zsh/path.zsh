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
unset LDFLAGS
