#!/bin/sh

echo "Backing up nvim files"
mv ~/.local/share/nvim ~/.local/share/nvim.bak_non_lazy
mv ~/.local/state/nvim ~/.local/state/nvim.bak_non_lazy
mv ~/.cache/nvim ~/.cache/nvim.bak_non_lazy

echo "Restoring lazy nvim files"
mv ~/.local/share/nvim.bak_lazy ~/.local/share/nvim
mv ~/.local/state/nvim.bak_lazy ~/.local/state/nvim
mv ~/.cache/nvim.bak_lazy ~/.cache/nvim

echo "Removing nvim configuration files"
rm -rf ~/.config/nvim
rcup
