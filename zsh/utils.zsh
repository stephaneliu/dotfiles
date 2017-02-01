is_linux() { [ "$(uname -s)" = Linux ] }

if is_linux; then
  export LD_LIBRARY_PATH=~/lib/x86_64-linux-gnu
  export DYLD_LIBRARY_PATH=/usr/local/lib:$DLYD_LIBRARY_PATH
fi

# Display result of last AV scan
if [[ -e "/usr/local/uvscan/report.sh" ]]
then
  /usr/local/uvscan/report.sh
fi

if [[ -e "$HOME/bin/jre1.7.0_45" ]]
then
  export JAVA_HOME=$HOME/bin/jre1.7.0_45
fi
