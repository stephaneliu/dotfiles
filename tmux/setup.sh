echo "# Configuring tmux"

platform=`uname`

echo "# Configuring tmux"

if [ -e ~/.tmux.conf ]
then
  echo "Renaming tmux.conf to tmux.conf_orig"
  mv -f ~/.tmux.conf ~/.tmux.conf.orig
fi

echo "Linking tmux.conf"
ln -sf $PWD/tmux.conf ~/.tmux.conf

if [ "$platform" == "Darwin" ]
then 
  if [ -e ~/.tmux-osx.conf ]
  then
    echo "Renaming .tmux-osx.conf to .tmux-osx.conf.orig"
    mv -f ~/.tmux-osx.conf ~/.tmux-osx.conf.orig
  fi

  echo "Linking tmux-osx.conf"
  ln -sf $PWD/tmux-osx.conf ~/.tmux-osx.conf
else
  if [ -e ~/.tmux-bsd.conf ]
  then
    echo "Renaming .tmux-bsd.conf to .tmux-bsd.conf.orig"
    mv -f ~/.tmux-bsd.conf ~/.tmux-bsd.conf.orig
  fi

  echo "Linking tmux-bsd.conf"
  ln -sf $PWD/tmux-bsd.conf ~/.tmux-bsd.conf
fi

if [ -e ~/.tmuxinator ]
then
  echo "Renaming .tmuxinator to .tmuxinator.orig"
  mv -f ~/.tmuxinator ~/.tmuxinator.orig
fi

echo "Linking tmuxinator"
ln -sf $PWD/tmuxinator ~/.tmuxinator
