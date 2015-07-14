echo "Enter your full name, followed by [ENTER]:"
read name

echo "Enter your email address, followed by [ENTER]:"
read email

echo "Enter your github username, followed by [ENTER]:"
read github_username

. ./git/setup.sh

sed -i -e 's/CHANGE_NAME/'"$name"'/' \
  -e 's/CHANGE_EMAIL/'"$email"'/' \
  -e 's/CHANGE_GITHUB/'"$github_username"'/' ~/.gitconfig

. ./tmux/setup.sh
. ./vim/setup.sh
