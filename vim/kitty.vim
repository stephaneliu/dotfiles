" nnoremap <leader>pair :let &background="light"<cr> | :silent !kitty @ set-colors --all ~/.config ~/.config/kitty/themes/solarized-light.conf && kitty @ set-font-size 22<cr>
nnoremap <leader>pair :let &background="light" \| :silent !kitty @ set-colors --all ~/.config/kitty/themes/solarized-light.conf && kitty @ set-font-size 22 <CR> \| <CR>
nnoremap <leader>dsolo :let &background="dark" \| :silent !kitty @ set-colors --all ~/.config/kitty/themes/solarized-dark.conf && kitty @ set-font-size 14 <CR> \| <CR>
nnoremap <leader>lsolo :let &background="light" \| :silent !kitty @ set-colors --all ~/.config/kitty/themes/solarized-light.conf && kitty @ set-font-size 14 <CR> \| <CR>
