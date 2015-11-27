if [ -e ~/.zsh_aliases ]
then
  echo "Renaming zsh_aliases to zsh_aliases.orig"
  mv ~/.zsh_aliases ~/.zsh_aliases.orig
fi
echo "Linking zsh_aliases"
ln -sf $PWD/zsh_aliases ~/.zsh_aliases


if [ -e ~/.zshrc ]
then
  echo "Renaming zshrc to zshrc.orig"
  mv ~/.zshrc ~/.zshrc.orig
fi
echo "Linking zshrc"
ln -sf $PWD/zshrc ~/.zshrc
