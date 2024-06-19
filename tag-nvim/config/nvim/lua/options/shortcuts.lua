v_map('D', 'y\'>p') -- Visual mode select then shift + d to paste selected text
c_map('cwd', 'lcd %:p:h') -- change working directory to that of file
n_map(';v', ':tabnew ~/.config/nvim/init.lua<CR>') -- " Display ~/.vimrc in new tab
n_map('<leader>rn', ':echo "use unimpared `yor` instead"<CR>') -- " relative and absolute rulers
nv_map('<leader>hash', ':s/:\\([^ ]*\\)\\(\\s*\\)=>/\\1:/g<CR>') -- convert hash rockets to json style
n_map('<C-=>', ':resize +3<CR>') -- current window split bigger
n_map('<C-->', ':resize -3<CR>') -- current window split smaller
n_map('<Space>', ':nohlsearch<Bar>:echo<CR>') -- Press Space to turn off highlighting and clear any message already displayed
c_map('w!!', '%!sudo tee > /dev/null') -- vice `sudo !!` from terminal
__map('<leader>bg', ':echo "use unimpaired `yob` instead"<CR>')
n_map('<leader>hl', ':echo "use unimpaired `yoc` instead"<CR>') -- toggle current line highlighting
c_map('fff', "f\\(des\\|con\\|it\\)<CR>") -- Find focus `:fff`
n_map('gp', "`[v`]`") -- reselect pasted text: https://vimtricks.com/p/reselect-pasted-text/

-- close window with q
n_map(';q', ':q<CR>')
n_map(';Q', ':q!<CR>')
n_map('<leader>t', ':quit<CR>')

-- simplify window navigation with ctrl
n_map('<C-j>', '<C-w>j')
n_map('<C-k>', '<C-w>k')
n_map('<C-l>', '<C-w>l')
n_map('<C-h>', '<C-w>h')

-- simplify tabbed navigation with shift
n_map('<S-H>', 'gT')
n_map('<S-L>', 'gt')

n_map('<leader>m', ":silent !open -a Marked\\ 2.app '%:p'<cr>")
