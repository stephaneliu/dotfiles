is_linux() { [ "$(uname -s)" = Linux ] }

if is_linux; then
  export LD_LIBRARY_PATH=~/lib/x86_64-linux-gnu
  export DYLD_LIBRARY_PATH=/usr/local/lib:$DLYD_LIBRARY_PATH
fi

