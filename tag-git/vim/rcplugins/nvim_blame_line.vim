Plug 'tveskag/nvim-blame-line' " https://github.com/tveskag/nvim-blame-line

nnoremap <silent> <leader>b :ToggleBlameLine<CR>

autocmd BufEnter * EnableBlameLine
