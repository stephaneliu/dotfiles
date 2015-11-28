echo "# Configuring vim"

if [ -e ~/.vimrc ]
then
  echo "Renaming .vimrc to .vimrc.orig"
  mv ~/.vimrc ~/.vimrc.orig
fi

echo "Linking .vimrc"
ln -sf $PWD/vimrc ~/.vimrc

if [ -d ~/.vim ]
then
  echo "Renaming .vim to .vim.orig"
  mv ~/.vim ~/.vim.orig
fi
echo "Linking .vim"
ln -sf $PWD/vim ~/.vim


if [ -d $HOME/tmp/vi-swap ]
then
  echo "Swap directory vi-swap exists"
else
  echo "Create tmp swap directory"
  mkdir $HOME/tmp/vi-swap
fi

if [ -d $HOME/tmp/vi-backup ]
  echo "Backup directory vi-backup exists"
then
  echo "Create backup directory"
  mkdir $HOME/tmp/vi-backup
fi

if [ -d $HOME/.vim/bundle ]
then
  echo "Bundle directory exists"
else
  echo "Creating bundle directory"
  mkdir ~/.vim/bundle
fi

if [ -d $HOME/.vim/bundle/Vundle.vim ]
then
  echo "Updating vundle"
  cd $HOME/.vim/bundle/Vundle.vim
  git pull
  cd -
else
  echo "Installing vundle (plugin manager for vim)"
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall
