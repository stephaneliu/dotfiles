if has('gui_running')
  set guioptions-=T                 " hide the toolbar - who uses it anyways?
endif

set guifont=Droid\ Sans\ Mono
set colorcolumn=150                " set a highlighted column at the 100th character on line

set statusline=1
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P " show git info

" use mouse to copy without line numbers in terminal 
set mouse=a
" set statusline=%t\ %y\ format:\ %{&ff};\ [%c,%l]
