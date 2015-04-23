if [ -d ~/.git_template ]
then
  mv ~/.git_template ~/.git_template_orig
fi
ln -sf $PWD/git/git_template ~/.git_template

if [ -e ~/.gitignore ]
then
  mv ~/.gitignore ~/.gitignore_orig
fi
ln -sf $PWD/git/global_ignores/gitignore ~/.gitignore
