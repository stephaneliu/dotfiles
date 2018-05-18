source $HOME/bin/os_type.sh

# g without arguments will run `git status`
function g {
  if [[ $# > 0 ]]; then
    hub $@
  else
    hub st
  fi
}

alias gad='hub add'
alias gbr='hub branch'
alias gcl='hub clone'
alias gco='hub checkout'
alias gci='hub commit'
alias gdf='hub diff'
alias ggg='hub g'
alias glg='hub l'
alias glgg='hub lg'
alias gll='hub lola'
alias gmg='hub mg'
alias gmt='hub mergetool'
alias gmv='hub mv'
alias gpl='hub pull'
alias gps='hub push'
alias grb='hub rebase'
alias grf='hub rm -rf'
alias grm='hub rm'
alias gst='hub stash'
alias gus='hub unstage'

# Complete g like git
compdef g=git
compdef _git gad=git-add
compdef _git gco=git-checkout
compdef _git gbr=git-branch
compdef _git gcl=git-clone
compdef _git gci=git-commit
compdef _git gdf=git-diff
compdef _git ggg=git-grep
compdef _git glg=git-log
compdef _git gmg=git-merge
compdef _git gmv=git-mv
compdef _git gpl=git-pull
compdef _git gps=git-push
compdef _git grm=git-rm
compdef _git grb=git-rebase
compdef _git gst=git-stash
compdef _git gus=git-reset


if is_osx; then
  if [ "$(git config --get credential.helper)" != "osxkeychain" ]; then
    echo "Configuring Git system scope credential helper to osxkeychain" 
    sudo git config --system --replace-all credential.helper 'osxkeychain'
  fi
elif is_centos || is_redhat; then
  # insure read permissions set correctly in order to git config --get
  sudo chmod 644 /etc/gitconfig

  if [ "$(git config --get credential.helper)" != "cache --timeout=86400" ]; then
    sudo git config --system --replace-all credential.helper 'cache --timeout=86400'
  fi
fi
