#!/bin/sh

echo "Backing up lazy nvim files"
mv ~/.local/share/nvim ~/.local/share/nvim.bak_lazy
mv ~/.local/state/nvim ~/.local/state/nvim.bak_lazy
mv ~/.cache/nvim ~/.cache/nvim.bak_lazy

echo "Restoring backup nvim files"
mv ~/.local/share/nvim.bak_non_lazy ~/.local/share/nvim
mv ~/.local/state/nvim.bak_non_lazy ~/.local/state/nvim
mv ~/.cache/nvim.bak_non_lazy ~/.cache/nvim

echo "Removing nvim configuration files"
rm -rf ~/.config/nvim
echo "Run rcup after switching branches"
