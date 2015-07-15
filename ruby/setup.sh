echo "# Configuring ruby"

if [ ~/.gemrc ]
then
  echo "Renaming .gemrc to .gemrc.orig"
  mv ~/.gemrc ~/.gemrc.orig
fi
echo "Linking .gemrc"
ln -sf $PWD/ruby/gemrc ~/.gemrc

if [ ~/.irbrc ]
then
  echo "Renaming .irbrc to .irbrc.orig"
  mv ~/.irbrc ~/.irbrc.orig
fi
echo "Linking irbrc"
ln -sf $PWD/ruby/irbrc ~/.irbrc

if [ ~/.rdebugrc ]
then
  echo "Renaming .rdebugrc to .rdebugrc.orig"
  mv ~/.rdebugrc ~/.rdebugrc.orig
fi
echo "Linking rdebugrc"
ln -sf $PWD/ruby/rdebugrc ~/.rdebugrc
