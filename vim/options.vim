set nocompatible                " increase compatability with plugins
set noswapfile
set history=10000
set incsearch                   " highlights letters while they're type in for search
set notimeout
set ttimeout
set timeoutlen=100
set ff=unix                     " save new lines without CR

set showcmd
set nu ruler                        " forces ruler to be visible (vice toggle)
set scrolloff=3                     " number of visible lines above and below cursor

" Create backups
set backup
set writebackup
set backupdir=~/.vim/backups

" Presistent undo
set undofile " Create FILE.un~ files
set undodir=~/.vim/undodir

" setting backupskip to allow crontab -e to use vim
if has('unix') " see: http://tim.theenchanter.com/2008/07/crontab-temp-file-must-be-ed
  set backupskip=/tmp/*,/private/tmp/*
endif

set autoindent
set copyindent " copy previous indentation
set showmatch

set ignorecase smartcase  " case sensitive search only if it contains upper-case char

set splitbelow splitright " Split below and right

set foldmethod=indent
set nofoldenable

" disable mouse
set mouse=
