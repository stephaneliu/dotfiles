# g without arguments will run `git status`
function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git st && git hidden
  fi
}

alias 'g-'='git co -'
alias ga='git a'
alias gad='git ad'
alias gbr='git br'
alias gbrr='git for-each-ref --color=always --sort=-committerdate refs/heads/ --format="%(color:bold green)%(committerdate:relative)%09%(color:bold yellow)%(refname:short)%(color:normal)" | tac'
alias gci='git commit'
alias gcp='git cherry-pick'
alias gcpc='git cherry-pick --continue'
alias gcpa='git cherry-pick --abort'
alias gcl='git clone'
alias gcln='git cln'
alias gco="git checkout"
alias gcr='gh cr'
alias gdc='git dc'
alias gdf='git df'
alias gds='git ds'
alias gl='git l'
alias glg='git lg'
alias gll='git ll'
alias glo='git lola'
alias gmg='git mg'
alias gmt='git mergetool'
alias gmv='git mv'
alias gpf='git pf'
alias gpl='git pull'
alias gprc='gh prc'
alias gprd='gh prd'
alias gprme='gh prme'
alias gps='git push'
alias grb='git rebase'
alias grba='OVERCOMMIT_DISABLE=1 git rba'
alias grbc='OVERCOMMIT_DISABLE=1 git rbc'
alias grm='git rm -rf'
alias gup='git up'
alias gus='git unstage'

__display_fzf_key_bindings() {
  echo ""
  echo "TAB or SHIFT-TAB to select multiple objects"
  echo "CTRL-/ to toggle preview window"
  echo "CTRL-O to open the object in the web browser (in GitHub URL scheme)"
  echo ""
}

gwip() {
  wips=("Crack that wip" "You must WIP it" "Now WIP it" "WIP it GOOD" "Unless you WIP it" "I say WIP it"  "To WIP it")
  optional_msg="$1 "
  git add .
  LOLCOMMITS_CAPTURE_DISABLED=true SAFE_COMMIT=1 OVERCOMMIT_DISABLE=1 git commit -m "*** $optional_msg'${wips[RANDOM % ${#wips[@]}]}' - Devo ***"
}

grbi() {
  if [[ $# -eq 0 ]]; then
    __display_fzf_key_bindings
    _fzf_git_each_ref --no-multi | xargs git rebase -i
  elif [ $(echo -n $1 | wc -c) -gt 2 ]; then
    # Rebase from the commit SHA to the last commit
    OVERCOMMIT_DISABLE=1 git rebase -i $1~1
  else
    # Rebase n commits from HEAD to the last commit
    OVERCOMMIT_DISABLE=1 git rebase -i HEAD~$1
  fi
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

glbr() {
  __display_fzf_key_bindings
  _fzf_git_branches --no-multi
}

# git delete branch
gbrd() {
  if [[ $# -eq 0 ]]; then
    __display_fzf_key_bindings
    echo ""
    echo "Selected branch will be deleted!"
    echo ""
    _fzf_git_branches --no-multi | xargs git br -d
  else
    # $@ - all arguments
    git br -d $1
  fi
}

# git list (show) reflog
glref() {
  __display_fzf_key_bindings

  if [[ $# -eq 0 ]]; then
    _fzf_git_lreflogs | xargs git reflog show -p
  elif [ $(echo -n $1 | wc -c) -lt 4 ]; then
    git reflog show -p HEAD@{@1}
  else
    echo "Provide the NUM from reflog HEAD@{NUM}"
  fi
}

# git check out reflog
gcoref() {
  __display_fzf_key_bindings

  _fzf_git_lreflogs --no-multi | xargs git checkout
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
