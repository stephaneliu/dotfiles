if [ -d ~/.zsh_aliases ]
then
  mv ~/.zsh_aliases ~/.zsh_aliases_orig
fi
ln -sf $PWD/zsh/zsh_aliases ~/.zsh_aliases

if [ -d ~/.zshrc ]
then
  mv ~/.zshrc ~/.zshrc_orig
fi
ln -sf $PWD/zsh/zshrc ~/.zshrc
