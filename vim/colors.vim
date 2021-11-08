" set term=screen-256color-bce

let s:uname = system("uname -s")

" switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax enable
  set hlsearch
  set background=dark
  colorscheme solarized
endif

set t_Co=256
colorscheme default
set background=dark
colorscheme solarized

" Added to support visual gitgutter display
highlight clear SignColumn
