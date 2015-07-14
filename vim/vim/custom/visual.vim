if has('gui_running')
  set guioptions-=T                 " hide the toolbar - who uses it anyways?
endif

set guifont=Droid\ Sans\ Mono
set colorcolumn=100                " set a highlighted column at the 100th character on line

" use mouse to copy without line numbers in terminal 
set mouse=a
" set statusline=%t\ %y\ format:\ %{&ff};\ [%c,%l]

set showcmd
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set nu ruler                        " forces ruler to be visible (vice toggle)
set autoindent
set scrolloff=3                     " number of visible lines above and below cursor
" set cursorline                      " highlight current line
set statusline=1
set laststatus=2                    " always show statuline
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P  " show git info
