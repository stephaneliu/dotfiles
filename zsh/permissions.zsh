source $HOME/bin/os_type.sh

if is_centos || is_redhat; then
  # Insure correct permissions on libraries
  sudo chmod 755 /usr/local/share/rcm
  sudo chmod 755 /usr/local/share/zsh
fi
