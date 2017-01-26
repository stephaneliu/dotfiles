set nocompatible
filetype off " required!

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" let Vundle manage Vundle, required!
Plugin 'gmarik/Vundle.vim'

" Web development
Plugin 'kchmck/vim-coffee-script'

" Colorcheme
Plugin 'altercation/vim-colors-solarized'
Plugin 'croaky/vim-colors-github'

"Syntax specific
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'tpope/vim-markdown'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'garbas/vim-snipmate'
Plugin 'godlygeek/tabular.git'
Plugin 'guns/xterm-color-table.vim'
Plugin 'honza/vim-snippets'
Plugin 'mattn/calendar-vim'
Plugin 'mileszs/ack.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/tcomment_vim'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/camelcasemotion'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/notes.vim'
Plugin 'vim-scripts/scratch.vim'
Plugin 'vim-scripts/simplefold'
Plugin 'vim-scripts/taglist.vim'
Plugin 'xolox/vim-misc'

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..