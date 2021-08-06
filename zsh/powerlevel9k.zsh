source $HOME/.dotfiles/bin/os_type.sh

frum_ruby() {
  local version=$(ruby -v | cut -d ' ' -f2 | cut -d 'p' -f1)
  echo -n "\ue21e $version"
}

POWERLEVEL9K_CUSTOM_FRUM_RUBY="frum_ruby"
POWERLEVEL9K_CUSTOM_FRUM_RUBY_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_FRUM_RUBY_BACKGROUND="red"

if is_osx; then
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_frum_ruby vi_mode vcs newline dir status)
else
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_frum_ruby vi_mode vcs newline dir status)
fi
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_CUSTOM_RUBY="echo -n '\ue21e'"
POWERLEVEL9K_CUSTOM_RUBY_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_RUBY_BACKGROUND="red"
