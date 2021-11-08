source $HOME/.dotfiles/bin/os_type.sh

# Homebrew
if [ -d /opt/homebrew/bin ]; then
  export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
elif [ -d $HOME/brew/bin/ ]; then
  export PATH=$HOME/homebrew/bin:$HOME/homebrew/sbin:$PATH
fi

export PATH=$HOME/bin:$PATH
unset LDFLAGS
