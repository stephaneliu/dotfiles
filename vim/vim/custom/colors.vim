" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif


set t_Co=256
let g:solorized_termcolors=256
set background=dark
" colorscheme solarized
colorscheme default

" Added to support visual gitgutter display
highlight clear SignColumn

" colorscheme desert
" colorscheme github
" let g:solarized_hitrail=1
"let g:solorized_termcolors=256
" set background=light
" colorscheme molokai_sjl
" colorscheme railscasts
