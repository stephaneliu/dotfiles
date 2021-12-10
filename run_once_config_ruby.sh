#!/bin/sh

echo "Installing latest Ruby"
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

if [ $? = 0 ]; then
  asdf install ruby latest
fi
