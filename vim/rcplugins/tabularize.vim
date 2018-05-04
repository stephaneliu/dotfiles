vmap <Leader>a= :Tabularize /^[^=]*\zs=/l1<CR>
vmap <Leader>ae :Tabularize /^[^=]*\zs=/l1<CR>
vmap <Leader>a: :Tabularize /^[^\ s+]*\zs,/r0l0l0<CR>
vmap <Leader>a; :Tabularize /:/l1r0<CR>
" Match only the first { from text selected
vmap <Leader>a{ :Tabularize /^[^{]*\zs{/<CR>
vmap <Leader>ah :Tabularize /=><CR>
vmap <Leader>a# :Tabularize /#<CR>
" match stabby lambda
vmap <Leader>a- :Tabularize /-><CR>
vmap <Leader>as :Tabularize /-><CR>
