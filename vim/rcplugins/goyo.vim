let g:goyo_width = 80
autocmd BufNewFile,BufRead *.vpm call SetVimPresentationMode()
function SetVimPresentationMode()
  Goyo
endfunction

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif

  set background=light
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set fillchars=eob:\  " remove tildes for empty lines

  nnoremap <buffer> <Right> :n<CR>
  nnoremap <buffer> <Left> :N<CR>
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif

  set background=dark
  set showmode
  set showcmd
  set scrolloff=5
  set fillchars=eob:\~
endfunction
autocmd! User GoyoLeave nested call <SID>goyo_leave()
