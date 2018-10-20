#!/bin/bash
source $HOME/.dotfiles/bin/os_type.sh

source_by_os() {
  if is_osx; then
    tmux source-file "$HOME/.tmux-osx.conf"
  fi
  if is_debian; then
    tmux source-file "$HOME/.tmux-bsd.conf"
  fi
  if is_redhat; then
    tmux source-file "$HOME/.tmux-rh.conf"
  fi
}

source_by_os
