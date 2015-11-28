echo "# Configuring ruby"

if [ -e ~/.gemrc ]
then
  echo "Renaming .gemrc to .gemrc.orig"
  mv ~/.gemrc ~/.gemrc.orig
fi
echo "Linking .gemrc"
ln -sf $PWD/gemrc ~/.gemrc


if [ -e ~/.irbrc ]
then
  echo "Renaming .irbrc to .irbrc.orig"
  mv ~/.irbrc ~/.irbrc.orig
fi
echo "Linking irbrc"
ln -sf $PWD/irbrc ~/.irbrc


if [ -e ~/.rdebugrc ]
then
  echo "Renaming .rdebugrc to .rdebugrc.orig"
  mv ~/.rdebugrc ~/.rdebugrc.orig
fi
echo "Linking rdebugrc"
ln -sf $PWD/rdebugrc ~/.rdebugrc
