#!/bin/sh

echo "Restoring backup nvim files"
mv ~/.local/share/nvim.bak ~/.local/share/nvim
mv ~/.local/state/nvim.bak ~/.local/state/nvim
mv ~/.cache/nvim.bak ~/.cache/nvim

echo "Removing nvim configuration files"
rm -rf ~/.config/nvim
echo "Run rcup after switching branches"
