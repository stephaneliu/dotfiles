_fzf_git_fzf() {
  fzf --height=100% \
    --layout=reverse --multi --min-height=20 --border \
    --border-label-pos=2 \
    --color='header:italic:underline,label:blue' \
    --preview-window='right,50%,border-left' \
    --bind='ctrl-/:change-preview-window(down,70%,border-top|hidden|)' "$@"
}
