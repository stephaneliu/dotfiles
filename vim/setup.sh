echo "# Configuring vim"

if [ -d ~/.vimrc ]
then
  echo "Renaming .vimrc to .vimrc.orig"
  mv ~/.vimrc ~/.vimrc.orig
fi

echo "Linking .vimrc"
ln -sf $PWD/vim/vimrc ~/.vimrc

if [ -d ~/.vim ]
then
  echo "Renaming .vim to .vim.orig"
  mv ~/.vim ~/.vim.orig
fi

echo "Linking .vim"
ln -sf $PWD/vim/vim ~/.vim

mkdir ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
