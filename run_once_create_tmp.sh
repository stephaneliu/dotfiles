#!/bin/sh

if [ ! -d $HOME/tmp ]; then
  echo "Creating a tmp folder in $HOME"
  mkdir $HOME/tmp
fi
