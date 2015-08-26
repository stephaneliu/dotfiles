set term=screen-256color-bce
let g:solorized_termcolors=256
set t_Co=256
set background=dark
colorscheme solarized
" colorscheme default

" Added to support visual gitgutter display
highlight clear SignColumn

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif
