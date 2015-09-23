" remap ESC in insert mode to jk/kj
inoremap jk <ESC>
inoremap kj <ESC>

" Visual mode select then shift + d to paste selected text
vmap D y'>p

" change working directory to that of file
cmap cwd lcd %:p:h

" Remaps navigation respecting camelcase and underscores in words
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
nmap <leader>rn :set rnu<CR>
nmap <leader>an :set nu<CR>
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
"
" autocmd InsertEnter * :set number
" autocmd InsertLeave * :set rnu!

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Press Space to turn off highlighting and clear any message already displayed
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" vice sudo !!
cmap w!! %!sudo tee > /dev/null %

