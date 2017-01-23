set nocompatible
filetype off " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'croaky/vim-colors-github'
Plugin 'davidoc/taskpaper.vim'
" Plugin 'ervandew/supertab'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'guns/xterm-color-table.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/calendar-vim'
Plugin 'mileszs/ack.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ngmy/vim-rubocop'
Plugin 'scrooloose/nerdtree'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-obsession'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vividchalk'
Plugin 'godlygeek/tabular.git'
Plugin 'vim-ruby/vim-ruby'
" Plugin 'vim-scripts/calendar.vim--Matsumoto'
Plugin 'vim-scripts/camelcasemotion'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/notes.vim'
Plugin 'vim-scripts/scratch.vim'
Plugin 'vim-scripts/simplefold'
Plugin 'vim-scripts/taglist.vim'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" vim-scripts github repo
" Bundle 'name-of-script'

" non gihub repo
" Bundle 'git://git.somewhere/something.git'


call vundle#end()
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
