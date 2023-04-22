Plug 'rking/ag.vim'

nnoremap \ :Ag! -Q --smart-case --ignore-dir app/frontend<Space>
nnoremap { :Ag! "\b<C-R>=expand("<cword>")<CR>\b"<CR>
