# Setup fzf
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi
# Auto-completion
# Activate with **
# vi ** TAB
# cat ** TAB
# cd ** TAB
# kill ** TAB
# ssh ** TAB
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null
# Key bindings
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_OPTS=" \
    --no-mouse \
    --height 80% -1 \
    --reverse \
    --multi \
    --inline-info \
    --preview '[[ \$(file --mime {}) =~ binary ]] & echo {} is a binary file || \
        (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300'
    --preview-window='right:hidden:wrap'
    --bind 'ctrl-o:execute(bat --style=numbers {} || less -f {})'"
        # ctrl+p:toggle-preview,\
        # ctrl-d:half-page-down,\
        # ctrl-u:half-page-up,\
        # ctrl-f:page-down,\
        # ctrl-b:page-up,\
        # ctrl-y:execute-silent(*echo {+} | pbcopy)'


# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
