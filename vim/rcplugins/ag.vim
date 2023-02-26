Plug 'rking/ag.vim'

nnoremap \ :Ag! -Q<Space>
nnoremap { :Ag! "\b<C-R>=expand("<cword>")<CR>\b"<CR>
