echo "# Configuring tmux'

if [ -d ~/.tmux.conf ]
then
  echo "Renaming tmux.conf to tmux.conf_orig"
  mv ~/.zsh_aliases ~/.zsh_aliases_orig
fi

echo "Linking tmux.conf"
ln -sf $PWD/tmux/tmux.conf ~/.tmux.conf

if [ -d ~/.tmuxinator ]
then
  echo "Renaming .tmuxinator to .tmuxinator.orig"
  mv ~/.tmuxinator ~/.tmuxinator.orig
fi

echo "Linking tmux.conf"
ln -sf $PWD/tmux/tmuxinator ~/.tmuxinator
