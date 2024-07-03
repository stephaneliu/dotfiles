# Setup fzf
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi
# Auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null
# Key bindings
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_OPTS=" \
    --no-mouse \
    --height 50% -1 \
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

# export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
# export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
# export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}
