" remap ESC in insert mode to jk/kj
inoremap jk <ESC>

" Visual mode select then shift + d to paste selected text
vmap D y'>p

" change working directory to that of file
cmap cwd lcd %:p:h

" close window with q
map <silent> ;q :q<CR>
map <silent> ;Q :q!<CR>

" Display ~/.vimrc in new tab
nmap <silent> ;v :tabnew ~/.dotfiles/zshrc<CR>

" relative and absolute rulers
nmap <leader>rn :set rnu!<CR>
nmap <leader>an :set rnu!<CR>

"convert hash rockets to json style
nmap <leader>hash :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>
vmap <leader>hash :s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>

" Removes ^M (carriage returns from file)
nmap <leader>;dcr :%s/\r//g<CR>

" simplify window navigation with ctrl
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" simplify tabbed navigation with shift
nmap <S-H> gT
nmap <S-L> gt

" current window split bigger
nmap <C-=> <ESC>:res +1

" remove trailing whitespace and tabs
noremap <silent> <F4> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>
noremap <F5> :buffers<CR>:buffer<Space>

map <leader>t :quit<CR>

" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>

" Press Space to turn off highlighting and clear any message already displayed
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" vice sudo !!
cmap w!! %!sudo tee > /dev/null %

map <silent> <leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" toggle current line highlighting
nmap <leader>hl :set cursorline!<CR>

cmap fff f\(des\\|con\\|it\)

nnoremap gp `[v`]` " reselect pasted text: https://vimtricks.com/p/reselect-pasted-text/
