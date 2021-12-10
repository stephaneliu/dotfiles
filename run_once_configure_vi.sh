#!/bin/sh

echo "Configuring NVIM"
if [ ! -d $HOME/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

echo "Installing Vim packages"
vi +PluginInstall +qa

echo "Installing coc language servers"
vi +"CocInstall coc-tailwindcss coc-sh coc-solargraph coc-json coc-html coc-css coc-json" +qa

# "Setting up coc-solargraph for vim"
gem install solargraph
nvim +CocInstall\ coc-solargraph +qa
echo "coc-solargraph configured. More info: https://github.com/neoclide/coc-solargraph"
