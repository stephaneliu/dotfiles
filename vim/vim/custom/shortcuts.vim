" remap ESC in insert mode to jk/kj
inoremap jk <ESC>
inoremap kj <ESC>

" Visual mode select then shift + d to paste selected text
vmap D y'>p

" change working directory to that of file
cmap cwd lcd %:p:h

" Remaps navigation respecting camelcase and underscores in words
" 09/19/2016: Isolated mapping w to camelcase will cause 'dw' command
" on the last word of the line to also delete the \n char
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e

" control+h to change the first word of the line
map <silent> <C-h> ^cw
" close window with q
map <silent> ;q :q<CR>
map <silent> ;Q :q!<CR>
" Display ~/.vimrc in new tab
nmap <silent> ;v :tabnew $MYVIMRC<CR>

map <leader>d :execute 'NERDTreeFind'<CR>
map <leader>tl :execute 'TlistToggle'<CR>
" relative and absolute rulers
nmap <leader>rn :set rnu!<CR>
nmap <leader>an :set rnu!<CR>
"convert hash rockets to json style
nmap <leader>hr :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>
vmap <leader>hr :s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>
" Removes ^M (carriage returns from file)
nmap <leader>;dcr :%s/\r//g<CR>


" simplify window navigation with ctrl
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l
nmap <C-H> <C-W>h
nmap <C-K> <C-W>k

" simplify tabbed navigation with shift
" nmap <S-H> :bp<CR>
" nmap <S-L> :bn<CR>
" simplify tabbed navigation with shift
nmap <S-H> gT
nmap <S-L> gt

" current window split bigger
nmap <C-=> <ESC>:res +1

" remove trailing whitespace and tabs
noremap <silent> <F4> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>
noremap <F5> :buffers<CR>:buffer<Space>

" map global search replace
nmap S :%s//g<LEFT><LEFT>
vmap S :s//g<LEFT><LEFT>

" Session management
nmap <F2> :mksession! ~/.vim_session <CR> " Quick write session with F2
nmap <F3> :source ~/.vim_session <CR> " And load session with F3

" New tmp file
map <leader>nt :Sscratch<CR>
map <leader>gg :GitGutterLineHighlightsToggle<CR>

map <leader>t :quit<CR>

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

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Press Space to turn off highlighting and clear any message already displayed
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" vice sudo !!
cmap w!! %!sudo tee > /dev/null %

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

" http://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character
" use :set list / :set nolist to toggle
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Projects
nmap <leader>w2 :e ~/code/netops/src/app/models/event.rb<CR>
