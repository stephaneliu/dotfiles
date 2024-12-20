# g without arguments will run `git status`
function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git st && git hidden
  fi
}

alias 'g-'='git co -'
alias gad='git ad'
alias ga='git a'
alias gbr='git br'
alias gbrr='git for-each-ref --color=always --sort=-committerdate refs/heads/ --format="%(color:bold green)%(committerdate:relative)%09%(color:bold yellow)%(refname:short)%(color:normal)" | tac'
alias gcl='git clone'
alias gco='git checkout'
alias gci='git commit'
alias gcln='git cln'
alias gcr='gh cr'
alias gprc='gh prc'
alias gprd='gh prd'
alias gprme='gh prme'
alias gdc='git dc'
alias gds='git ds'
alias gdf='git df'
alias gl='git l'
alias glg='git lg'
alias gll='git ll'
alias glo='git lola'
alias gmg='git mg'
alias gmt='git mergetool'
alias gmv='git mv'
alias gpl='git pull'
alias gps='git push'
alias gpf='git pf'
alias grb='git rebase'
alias grba='OVERCOMMIT_DISABLE=1 git rba'
alias grbc='OVERCOMMIT_DISABLE=1 git rbc'
alias grm='git rm -rf'
alias gup='git up'
alias gus='git unstage'

gwip() {
  wips=("Crack that wip" "You must WIP it" "Now WIP it" "WIP it GOOD" "Unless you WIP it" "I say WIP it"  "To WIP it")
  optional_msg="$1 "
  git add .
  LOLCOMMITS_CAPTURE_DISABLED=true SAFE_COMMIT=1 OVERCOMMIT_DISABLE=1 git commit -m "*** $optional_msg'${wips[RANDOM % ${#wips[@]}]}' - Devo ***"
}

grbi() {
  if [ $(echo -n $1 | wc -c) -gt 2 ]; then
    # Rebase from the commit SHA to the last commit
    OVERCOMMIT_DISABLE=1 git rebase -i $1~1
  else
    # Rebase n commits from HEAD to the last commit
    OVERCOMMIT_DISABLE=1 git rebase -i HEAD~$1
  fi
}

gtest() {
  if [ $(echo -n $1 | wc -c) -gt 2 ]; then
    echo "$1 is greater than 2 characters"
  else
    echo "$1 is less than 3 characters"
  fi

  return 0
}

grs() {
  git reset --soft HEAD~$1
}

grsh() {
  git reset --hard HEAD~$1
}

# [g]it [c]ommit [r]e[b]ase
# Make a commit with the intent on rebasing & squashing it later
# Needs a reference to the commit you are squashing with
gcrb() {
  git add .
  git commit -m "**** Squash with $1 ****"
}

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


# This conditional does not work during zsh load
if [ "$(git config --get --system credential.helper)" != "osxkeychain" ]; then
  echo "Configuring Git system scope credential helper to osxkeychain"
  sudo git config --system --replace-all credential.helper 'osxkeychain'
fi
