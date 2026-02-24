# Auto-start zellij in Ghostty (not in nested sessions)
if [[ "$TERM" == "xterm-ghostty" ]] && [[ -z "$ZELLIJ" ]]; then
  zellij attach -c
fi

# Zellij aliases
alias zj="zellij"
alias zja="zellij attach"
alias zjl="zellij list-sessions"
