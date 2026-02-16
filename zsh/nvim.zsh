alias vim="echo \"Use v\""
alias v='nvim +OpenSession'

# Open nvim with session named after current directory and git branch
function vv() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -z "$branch" ]]; then
    echo "Not in a git repository"
    return 1
  fi

  local dir=$(basename "$PWD")
  dir="${dir#.}"
  local session_name="${dir}-${branch}"
  echo "Opening session: $session_name"
  local session_file="$HOME/.config/nvim/sessions/${session_name}.vim"
  if [[ -f "$session_file" ]]; then
    nvim "+OpenSession! $session_name"
  else
    echo -n "$session_name" | pbcopy
    echo "Session $session_name not found. Use :SS to create. Or use :SaveSession <Cmd-V> to create."
    read "?Press Enter to open nvim..."
    local first_file=$(ls -1p | grep -v '/' | head -1)
    nvim "$first_file"
  fi
}
