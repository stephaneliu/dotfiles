if [ -e ~/.editrc ]
then
  echo "Renaming editrc to editrc.orig"
  mv ~/.editrc ~/.edit_rc.orig
fi
echo "Linking editrc"
ln -sf $PWD/editrc ~/.editrc


if [ -e ~/.inputrc ]
then
  echo "Renaming .inputrc to .inputrc.orig"
  mv ~/.inputrc ~/.inputrc.orig
fi
echo "Linking inputrc"
ln -sf $PWD/inputrc ~/.inputrc


if [ -e ~/.zsh_aliases ]
then
  echo "Renaming zsh_aliases to zsh_aliases.orig"
  mv ~/.zsh_aliases ~/.zsh_aliases.orig
fi
echo "Linking zsh_aliases"
ln -sf $PWD/zsh_aliases ~/.zsh_aliases

if [ -e ~/.zsh_aliases ]
then
  echo "Renaming zsh_aliases_linux to zsh_aliases_linux.orig"
  mv ~/.zsh_aliases_linux ~/.zsh_aliases.orig
fi
echo "Linking zsh_aliases"
ln -sf $PWD/zsh_aliases_linux ~/.zsh_aliases_linux

if [ -e ~/.zshrc ]
then
  echo "Renaming zshrc to zshrc.orig"
  mv ~/.zshrc ~/.zshrc.orig
fi
echo "Linking zshrc"
ln -sf $PWD/zshrc ~/.zshrc
