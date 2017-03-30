if has('gui_running')
  set guioptions-=T                 " hide the toolbar - who uses it anyways?
endif

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

" http://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character
" use :set list / :set nolist to toggle
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

set rnu
function! NumberToggle()
  if(&relativenumber == 1)
    set rnu!
  else
    set relativenumber
  endif
endfunc
noremap <C-n> :call NumberToggle()<cr>
:au FocusLost * :set number
:au FocusGained * :set rnu!
autocmd InsertEnter * :set number
autocmd InsertLeave * :set rnu!
set numberwidth=3

if has('gui_running')
  set guioptions-=T                 " hide the toolbar - who uses it anyways?
endif

set guifont=Droid\ Sans\ Mono
set colorcolumn=100                 " set a highlighted column at the 100th character on line
set textwidth=100                   " word wrap at 100 characters
set wrapmargin=2                    " command to actually wrap on the display

set statusline=1
set laststatus=2                    " always show statuline
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P  " show git info
