set nocompatible
filetype off " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'airblade/vim-gitgutter'
Bundle 'croaky/vim-colors-github'
Bundle 'davidoc/taskpaper.vim'
Bundle 'ervandew/supertab'
Bundle 'guns/xterm-color-table.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'mileszs/ack.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/nerdtree'
Bundle 'thoughtbot/vim-rspec'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'xolox/vim-misc'
Bundle 'tpope/vim-projectionist'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-vividchalk'
" Bundle 'tsaleh/vim-align'
Bundle 'godlygeek/tabular.git'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/calendar.vim--Matsumoto'
Bundle 'vim-scripts/camelcasemotion'
Bundle 'vim-scripts/matchit.zip'
Bundle 'vim-scripts/notes.vim'
Bundle 'vim-scripts/scratch.vim'
Bundle 'vim-scripts/simplefold'
Bundle 'vim-scripts/taglist.vim'

" vim-scripts github repo
" Bundle 'name-of-script'

" non gihub repo
" Bundle 'git://git.somewhere/something.git'


filetype plugin indent on " required

"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
