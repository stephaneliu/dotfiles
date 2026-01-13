# g without arguments will run `git status`
function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git st && git hidden
  fi
}

alias 'g-'='git co -'

ga() {
  if [[ $1 == "." ]]; then
    git a -- ':!.claude' ':!.docs' .
  else
    git a "$@"
  fi
}

alias gad='git ad'
alias gbr='git br'

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

alias gbrr='echo use glbr instead'
alias gbrr='git for-each-ref --color=always --sort=-committerdate refs/heads/ --format="%(color:bold green)%(committerdate:relative)%09%(color:bold yellow)%(refname:short)%(color:normal)" | tac'
alias gci='git commit'

gco() {
  # Handle -b flag for creating new branches
  if [[ $1 == "-b" && $# -eq 2 ]]; then
    branch_name="$2"
    # If branch name is just a number, transform to CONSUME-[number]
    if [[ $branch_name =~ ^([0-9]+)$ ]]; then
      branch_name="CONSUME-$branch_name"
    # If branch name is a number followed by hyphenated string, transform to CONSUME-[number]-[string]
    elif [[ $branch_name =~ ^C([0-9]+)(-.*)?$ ]]; then
      jira_number="${match[1]}"
      rest_of_name="${match[2]}"
      branch_name="CONSUME-$jira_number$rest_of_name"
    # If branch name starts with C followed by numbers, transform to CONSUME-[number]
    elif [[ $branch_name =~ ^C([0-9]{1,9})(.*)$ ]]; then
      jira_number="${match[1]}"
      rest_of_name="${match[2]}"
      branch_name="CONSUME-$jira_number$rest_of_name"
    fi
    git checkout -b "$branch_name"
    return
  fi

  # Handle gco . to checkout all files
  if [[ $1 == "." ]]; then
    git checkout .
    return
  fi

  # checks if argument starts with C followed by up to 9 digits
  # C1234 refers to a branch that starts with CONSUME-1234
  if [[ $1 =~ ^C([0-9]{1,9})$ ]]; then
    jira_number="${match[1]}"
    transformed_arg="CONSUME-$jira_number"
    branch_name=$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads | grep -i "$transformed_arg-*" | head -n 1)

    if [ ${#branch_name} -eq 0 ]; then
      echo "No git branches exists for Jira ticket $transformed_arg."
    else
      git checkout "$branch_name"
    fi
  else
    git checkout $1
  fi
}

# git check out reflog
gcoref() {
  __display_fzf_key_bindings

  _fzf_git_lreflogs --no-multi | xargs git checkout
}

alias gcp='git cherry-pick'
alias gcpc='git cherry-pick --continue'
alias gcpa='git cherry-pick --abort'
alias gcl='git clone'
alias gcln='git cln'
# Get code reviews for repo
alias gcr='gh cr'

# [g]it [c]ommit [r]e[b]ase
# Make a commit with the intent on rebasing & squashing it later
# Needs a reference to the commit you are squashing with
gcrb() {
  git add -- ':!.claude' ':!.docs' .
  git commit -m "**** Squash with $1 ****"
}

alias gdc='git dc'
alias gdf='git df'
alias gds='git ds'

ghist() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: ghist <file_path> [search_term]"
    echo "Example: ghist zshrc function"
    return 1
  elif [[ $# -eq 1 ]]; then
    git lg --all --full-history -- "$1"
  else
    git lg --all --full-history -- "$1" | ag "$2" -A 20 -B 20 --smart-case | less
  fi
}

alias gl='git l'

glbr() {
  __display_fzf_key_bindings
  _fzf_git_branches --no-multi | xargs git co
}

alias gll='git ll'
alias glll='git lll'
alias glo='git lola'

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

alias grbc='OVERCOMMIT_DISABLE=1 git rbc'
alias grm='git rm -rf'

grs() {
  if [ $(echo -n $1 | wc -c) -gt 2 ]; then
    git reset --soft $1
  else
    git reset --soft HEAD~$1
  fi
}

grsh() {
  if [ $(echo -n $1 | wc -c) -gt 2 ]; then
    git reset --hard $1
  else
    git reset --hard HEAD~$1
  fi
}

alias gup='git up'
alias gus='git unstage'

gwip() {
  wips=("Crack that wip" "You must WIP it" "Now WIP it" "WIP it GOOD" "Unless you WIP it" "I say WIP it"  "To WIP it")
  optional_msg="$1 "
  git add -- ':!.claude' ':!.docs' .
  LOLCOMMITS_CAPTURE_DISABLED=true SAFE_COMMIT=1 OVERCOMMIT_DISABLE=1 git commit -m "*** $optional_msg'${wips[RANDOM % ${#wips[@]}]}' - Devo ***"
}

__display_fzf_key_bindings() {
  echo ""
  echo "TAB or SHIFT-TAB to select multiple objects"
  echo "CTRL-/ to toggle preview window"
  echo "CTRL-O to open the object in the web browser (in GitHub URL scheme)"
  echo ""
}

# Complete g like git
compdef g=git
compdef _git gad=git-add
compdef _git gap=git-add
# Custom completion for gco function
_gco() {
  local context state state_descr line
  local -A opt_args

  _arguments -C \
    '-b[create and switch to new branch]:branch name:' \
    '*::branch:_gco_branches'
}

# Helper function to complete with git branch names
_gco_branches() {
  local branches
  branches=($(git branch --format='%(refname:short)' 2>/dev/null))
  _describe 'branches' branches
}

compdef _gco gco
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
