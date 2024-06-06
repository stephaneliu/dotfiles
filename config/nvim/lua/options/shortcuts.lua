-- remap ESC in insert mode to jk/kj
i_keymap('jk', '<ESC>')

-- Visual mode select then shift + d to paste selected text
v_keymap('D', 'y\'>p')

-- change working directory to that of file
-- 'c' bindings, abbreviations, currently doesn't work in Lua
-- vim.keymap.set('c', 'cwd', 'lcd %:p:h', {noremap = true})

-- close window with q
n_keymap(';q', ':q<CR>')
n_keymap(';Q', ':q!<CR>')
n_keymap('<leader>t', ':quit<CR>')

-- " Display ~/.vimrc in new tab
n_keymap(';v', ':tabnew ~/.config/nvim/init.lua<CR>')

-- " relative and absolute rulers
n_keymap('<leader>rn', ':echo "use unimpared#yor"<CR>')

-- convert hash rockets to json style
nv_keymap('<leader>hash', ':s/:\\([^ ]*\\)\\(\\s*\\)=>/\\1:/g<CR>')

-- simplify window navigation with ctrl
n_keymap('<C-j>', '<C-w>j')
n_keymap('<C-k>', '<C-w>k')
n_keymap('<C-l>', '<C-w>l')
n_keymap('<C-h>', '<C-w>h')

-- simplify tabbed navigation with shift
n_keymap('<S-H>', 'gT')
n_keymap('<S-L>', 'gt')

-- current window split bigger
n_keymap('<C-=>', ':resize +3<CR>')
-- current window split smaller
n_keymap('<C-->', ':resize -3<CR>')

-- remove trailing whitespace and tabs
-- noremap <silent> <F4> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>
-- noremap <F5> :buffers<CR>:buffer<Space>


-- Press Space to turn off highlighting and clear any message already displayed
n_keymap('<Space>', ':nohlsearch<Bar>:echo<CR>')

-- vice sudo !!
-- cmap w!! %!sudo tee > /dev/null %

-- toggle background color
-- Use unimpaired - yob
-- map <silent> <leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

-- toggle current line highlighting
-- Use unimpaired - yoc
-- nmap <leader>hl :set cursorline!<CR>

-- vim.api.nvim_set_keymap('c', 'fff', "f\\(des\\\\|con\\\\|it\\)<CR>", {noremap = true})
-- vim.cmd[[cnoreabbrev fff f\(des\\|con\\|it\)<CR>]]
-- vim.cmd[[cnoreabbrev fff finding]]
-- vim.keymap.set("ca", "fff", "f\\(des\\\\|con\\\\|it\\)<CR>", {noremap = true})
-- cmap fff f\(des\\|con\\|it\)<CR>

-- nnoremap gp `[v`]` " reselect pasted text: https://vimtricks.com/p/reselect-pasted-text/
