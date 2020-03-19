source $HOME/.dotfiles/bin/os_type.sh

if is_osx; then
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(chruby vi_mode vcs newline dir status)
else
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(chruby vi_mode vcs newline dir status)
fi
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_CUSTOM_RUBY="echo -n '\ue21e'"
POWERLEVEL9K_CUSTOM_RUBY_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_RUBY_BACKGROUND="red"
