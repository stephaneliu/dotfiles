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

# Prevent git from using CAC by default - defer to project or use git cac to reinstate, uncac to
# remove
unset GIT_SSL_CERT 
