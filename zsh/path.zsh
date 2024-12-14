export PATH=$HOME/bin:$(brew --prefix)/opt/libpq/bin:$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH
export PATH=$PATH:$HOME/.yarn/bin
unset LDFLAGS
# Homebrew paths to build ruby gems natively
export LIBRARY_PATH=$LIBRARY_PATH:/opt/homebrew/lib/
export CPATH=$CPATH:/opt/homebrew/include/
