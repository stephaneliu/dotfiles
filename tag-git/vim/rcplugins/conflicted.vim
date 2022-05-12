
function! s:setupConflicted()
    set stl+=%{ConflictedVersion()}
    " Resolve and move to next conflicted file
    nnoremap ]m :GitNextConflict<cr>
endfunction
autocmd myVimrc User VimConflicted call s:setupConflicted()

let g:diffget_local_map = 'gl'
let g:diffget_upstream_map = 'gu'
