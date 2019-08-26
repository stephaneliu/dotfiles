#!/bin/bash
source $HOME/.dotfiles/bin/os_type.sh

load_env_by_os() {
  if is_osx; then
    ""
  elif is_debian; then
    ""
  elif is_redhat; then
    export TERM=xterm-256color
    export LANG=en_US.UTF-8
  fi
}

load_env_by_os

export USEPG=true
