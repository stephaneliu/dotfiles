Plug 'airblade/vim-gitgutter'

let g:gitgutter_highlight_lines = 1
map <leader>ggh :GitGutterLineHighlightsToggle<CR>
map <leader>ggf :GitGutterFold<CR>

highlight clear SignColumn
highlight GitGutterAdd guifg=#009900 ctermfg=2 ctermbg=0
highlight GitGutterChange guifg=#bbbb00 ctermfg=3 ctermbg=0
highlight GitGutterDelete guifg=#ff2222 ctermfg=1 ctermbg=0
