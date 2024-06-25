#!/bin/sh

echo "Backing up nvim files"
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

echo "Removing nvim configuration files"
rm -rf ~/.config/nvim
rcup
