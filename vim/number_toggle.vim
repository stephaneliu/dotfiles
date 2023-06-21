function! NumberToggle()
  if(&relativenumber == 1)
    set rnu!
  else
    set relativenumber
  endif
endfunc

" relative and absolute rulers
nmap <leader>rn :set rnu!<CR>
nmap <leader>an :set rnu!<CR>
noremap <C-n> :call NumberToggle()<cr>
