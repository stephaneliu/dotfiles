# Display result of last AV scan
if [[ -e "/usr/local/uvscan/report.sh" ]]
then
  /usr/local/uvscan/report.sh
fi

if [[ -e "$HOME/bin/jre1.7.0_45" ]]
then
  export JAVA_HOME=$HOME/bin/jre1.7.0_45
fi
