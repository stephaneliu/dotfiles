-- remap ESC in insert mode to jk/kj
vim.keymap.set('i', 'jk', '<ESC>', {noremap = true})

-- Visual mode select then shift + d to paste selected text
vim.keymap.set('v', 'D', 'y\'>p', {noremap = true})

-- change working directory to that of file
vim.keymap.set('c', 'cwd', 'lcd %:p:h', {noremap = true})

-- close window with q
vim.keymap.set('n', ';q', ':q<CR>', {noremap = true})
vim.keymap.set('n', ';Q', ':q!<CR>', {noremap = true})

-- " Display ~/.vimrc in new tab
vim.keymap.set('n', ';v', ':tabnew ~/.config/nvim/init.lua<CR>', {noremap = true})

-- " relative and absolute rulers
vim.keymap.set('n', '<leader>rn', ':set rnu!<CR>', {noremap = true})
vim.keymap.set('n', '<leader>an', ':set rnu!<CR>', {noremap = true})

-- convert hash rockets to json style
vim.keymap.set('n', '<leader>hash', ':s/:\\([^ ]*\\)\\(\\s*\\)=>/\\1:/g<CR>', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>hash', ':s/:\\([^ ]*\\)\\(\\s*\\)=>/\\1:/g<CR>', {noremap = true})

-- simplify window navigation with ctrl
vim.keymap.set('n', '<C-j>', '<C-w>j', {noremap = true})
vim.keymap.set('n', '<C-k>', '<C-w>k', {noremap = true})
vim.keymap.set('n', '<C-l>', '<C-w>l', {noremap = true})
vim.keymap.set('n', '<C-h>', '<C-w>h', {noremap = true})

-- simplify tabbed navigation with shift
vim.keymap.set('n', '<S-H>', 'gT', {noremap = true})
vim.keymap.set('n', '<S-L>', 'gt', {noremap = true})

-- current window split bigger
vim.keymap.set('n', '<C-=>', ':resize +3<CR>', {noremap = true})
-- current window split smaller
vim.keymap.set('n', '<C-->', ':resize -3<CR>', {noremap = true})

-- remove trailing whitespace and tabs
-- noremap <silent> <F4> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>
-- noremap <F5> :buffers<CR>:buffer<Space>

vim.keymap.set('n', '<leader>t', ':quit<CR>', {noremap = true})

-- Press Space to turn off highlighting and clear any message already displayed
vim.keymap.set('n', '<Space>', ':nohlsearch<Bar>:echo<CR>', {noremap = true})

-- vice sudo !!
-- cmap w!! %!sudo tee > /dev/null %

vim.keymap.set('n', '<leader>bg', ':let &background = ( &background == "dark"? "light" : "dark" )<CR>', {noremap = true})
-- map <silent> <leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
--
-- " toggle current line highlighting
-- nmap <leader>hl :set cursorline!<CR>
--
-- cmap fff f\(des\\|con\\|it\)<CR>
--
-- nnoremap gp `[v`]` " reselect pasted text: https://vimtricks.com/p/reselect-pasted-text/
