source $HOME/bin/os_type.sh

# g without arguments will run `git status`
function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git st
  fi
}

alias 'g-'='git co -'
alias gad='git add --patch'
alias gap='git add --patch'
alias gbr='git br'
alias gcl='git clone'
alias gco='git checkout'
alias gci='git commit'
alias gcln='git clean -fd'
alias gdc='git diff --cached'
alias gdf='git df'
alias glg='git lg'
alias gll='git lola'
alias gmg='git mg'
alias gmt='git mergetool'
alias gmv='git mv'
alias gpl='git pull'
alias gps='git push'
alias grb='git rebase'
alias grba='OVERCOMMIT_DISABLE=1 git rebase --abort'
alias grbi='OVERCOMMIT_DISABLE=1 git rebase -i'
alias grbc='OVERCOMMIT_DISABLE=1 git rebase --continue'
alias grs='git reset'
alias grsh='git reset --hard'
alias grm='git rm -rf'
alias gus='git unstage'
alias gwip="git add . && OVERCOMMIT_DISABLE=1 git commit -m \"***** Chore: WIP WIP WIP *****\""
alias gl='git l'

alias nocac='export _GIT_SSL_CERT=$GIT_SSL_CERT && unset GIT_SSL_CERT'
alias yescac='export GIT_SSL_CERT=$_GIT_SSL_CERT && unset _GIT_SSL_CERT'

# Complete g like git
compdef g=git
compdef _git gad=git-add
compdef _git gap=git-add
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
  # This conditional does not work during zsh load
  if [ "$(git config --get --system credential.helper)" != "osxkeychain" ]; then
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
