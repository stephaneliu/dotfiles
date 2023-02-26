Plug 'christoomey/vim-conflicted'

set stl+=%{ConflictedVersion()}
" Resolve and move to next conflicted file
nnoremap ]m :GitNextConflict<cr>

let g:diffget_local_map = 'gl'
let g:diffget_upstream_map = 'gu'
