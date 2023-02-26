" Make CtrlP use ag for listing the files. Way faster and no useless files.
" Without --hidden, it never finds .travis.yml since it starts with a dot.

Plug 'ctrlpvim/ctrlp.vim'

let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
" Disable caching, ag is fast enough
let g:ctrlp_use_caching = 0
set wildignore+=*/tmp/*,*/log/*,*.swp,*.zip,*/coverage/*
