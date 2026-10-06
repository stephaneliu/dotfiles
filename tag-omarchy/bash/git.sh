# Bash shortcuts matching zsh/git.zsh.
# Omarchy defines g as an alias; remove it before defining the function.
unalias g 2>/dev/null || true
GIT_EXCLUDE_DIRS=(.claude .docs docs)

g() {
  if (( $# )); then
    git "$@"
  else
    git st
    git hidden
  fi
}

ga() {
  if [[ ${1-} == . ]]; then
    local dir
    local excludes=()
    for dir in "${GIT_EXCLUDE_DIRS[@]}"; do excludes+=(":!$dir"); done
    git a -- "${excludes[@]}" .
  else
    git a "$@"
  fi
}

gbr() { git br "$@"; }

gco() {
  local branch_name jira_number
  if [[ ${1-} == -b && $# -eq 2 ]]; then
    branch_name=$2
    if [[ $branch_name =~ ^[0-9]+$ ]]; then
      branch_name="CONSUME-$branch_name"
    elif [[ $branch_name =~ ^C([0-9]{1,9})(.*)$ ]]; then
      branch_name="CONSUME-${BASH_REMATCH[1]}${BASH_REMATCH[2]}"
    fi
    git checkout -b "$branch_name"
  elif [[ ${1-} =~ ^C([0-9]{1,9})$ ]]; then
    jira_number=${BASH_REMATCH[1]}
    branch_name=$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads | rg -i "^CONSUME-${jira_number}(-|$)" | head -n 1)
    if [[ -n $branch_name ]]; then
      git checkout "$branch_name"
    else
      printf 'No git branches exist for Jira ticket CONSUME-%s.\n' "$jira_number"
      return 1
    fi
  else
    git checkout "$@"
  fi
}

gcln() {
  local dir
  local args=()
  for dir in "${GIT_EXCLUDE_DIRS[@]}"; do args+=(-e "$dir"); done
  git clean "${args[@]}" "$@"
}

alias 'g-'='git co -'
alias gad='git ad'
alias gbrr='git for-each-ref --color=always --sort=-committerdate refs/heads/ --format="%(color:bold green)%(committerdate:relative)%09%(color:bold yellow)%(refname:short)%(color:normal)" | tac'
alias gci='git commit'
alias gcp='git cherry-pick'
alias gcpc='git cherry-pick --continue'
alias gcpa='git cherry-pick --abort'
alias gcl='git clone'
alias gcr='gh cr'
alias gdc='git dc'
alias gdf='git df'
alias gds='git ds'
alias gl='git l'
alias gll='git ll'
alias glll='git lll'
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

# Bash Git completion supports the same shortcuts as Zsh's compdef.
if declare -F _completion_loader >/dev/null; then
  _completion_loader git
fi
if declare -F __git_complete >/dev/null; then
  __git_complete g __git_main
  __git_complete ga _git_add
  __git_complete gbr _git_branch
  __git_complete gco _git_checkout
  __git_complete gci _git_commit
  __git_complete gcl _git_clone
  __git_complete gdf _git_diff
  __git_complete gps _git_push
  __git_complete gpl _git_pull
  __git_complete grb _git_rebase
fi
