" Remaps navigation respecting camelcase and underscores in words
" 09/19/2016: Isolated mapping w to camelcase will cause 'dw' command
" on the last word of the line to also delete the \n char

Plug 'vim-scripts/camelcasemotion'

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
