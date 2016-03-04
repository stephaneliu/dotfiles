echo "# Configuring git"

if [ -e ~/.gitconfig ]
then
  echo "Renaming .gitconfig to .gitconfig.orig"
  mv ~/.gitconfig ~/.gitconfig.orig
fi


if [ -d ~/.git_template ]
then
  echo "Renaming .git_template to .git_template.orig"
  mv ~/.git_template ~/.git_template.orig
fi
echo "Linking git_template"
ln -sf $PWD/git_template ~/.git_template


if [ -e ~/.gitignore_global ]
then
  echo "Renaming .gitignore_global to .gitirgnore_global.orig"
  mv ~/.gitignore_global ~/.gitignore_global.orig
fi
echo "Linking gitignore_global"
ln -sf $PWD/gitignore_global ~/.gitignore_global


echo "Configuring git"
echo "Enter your full name, followed by [ENTER]:"
read name

echo "Enter your email address, followed by [ENTER]:"
read email

echo "Enter your github username, followed by [ENTER]:"
read github_username


git config --global init.templatefir '~/.git_template'
git config --global user.name "$name"
git config --global user.email "$email"
git config --global github.user "$github_username"
git config --global color.ui 'auto'
git config --global color.branch.current 'yellow reverse'
git config --global color.branch.local 'yellow'
git config --global color.branch.remote 'green'
git config --global color.diff.meta 'yellow bold'
git config --global color.diff.frag 'magenta bold'
git config --global color.diff.old 'red bold'
git config --global color.diff.new 'green bold'
git config --global color.diff.whitespace 'red reverse'
git config --global color.status.added 'yellow'
git config --global color.status.changed 'green'
git config --global color.status.untracked 'cyan'
git config --global core.whitespace 'fix,-indent-with-non-tab,trailing-space,cr-at-eol'
git config --global core.quotepath 'false'
git config --global core.excludesfile '~/.gitignore'
git config --global core.ff 'only'
git config --global alias.a 'add --patch'
git config --global alias.br 'branch'
git config --global alias.st 'status'
git config --global alias.ci 'commit'
git config --global alias.co 'checkout'
git config --global alias.df 'diff'
git config --global alias.lg 'log -p'
git config --global alias.lgg 'log --oneline'
git config --global alias.lolauth 'log --graph --decorate --pretty=short --abbrev-commit'
git config --global alias.lol 'log --graph --decorate --pretty=oneline --abbrev-commit'
git config --global alias.lola 'log --graph --decorate --pretty=oneline --abbrev-commit --all'
git config --global alias.lolaauth 'log --graph --decorate --pretty=short --abbrev-commit --all'
git config --global alias.mg 'merge --no-ff'
git config --global alias.unstage 'reset HEAD'
git config --global alias.up 'pull --rebase'
git config --global alias.undo 'reset --soft HEAD^'
git config --global alias.ignore 'update-index --assume-unchanged'
git config --global alias.unignore 'update-index --no-assume-unchanged'
git config --global alias.ignored '!git ls-files -v | grep "^[[:lower:]]"'
git config --global alias.tags 'tag --list'
git config --global mergetool.keepBackup 'false'
git config --global rerere.enabled 'true'
git config --global merge.tool 'vimdiff'
git config --global web.browser 'firefox'
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default 'matching'
git config --global credential.helper osxkeychain
