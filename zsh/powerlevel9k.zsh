source $HOME/.dotfiles/bin/os_type.sh

ruby_version() {
  local ruby_version=$(ruby -v | cut -d ' ' -f2 | cut -d 'p' -f1)
  echo -n "\ue21e $ruby_version"
}

node_version() {
  local node_version=$(node -v | cut -d 'v' -f2)
  echo -n "\u2B21 $node_version"
}

POWERLEVEL9K_CUSTOM_RUBY_VERSION="ruby_version"
POWERLEVEL9K_CUSTOM_RUBY_VERSION_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_RUBY_VERSION_BACKGROUND="red"

POWERLEVEL9K_CUSTOM_NODE_VERSION="node_version"
POWERLEVEL9K_CUSTOM_NODE_VERSION_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_NODE_VERSION_BACKGROUND="green"

if is_osx; then
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_ruby_version vi_mode vcs newline dir status)
else
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_ruby_version vi_mode vcs newline dir status)
fi

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time custom_node_version)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
