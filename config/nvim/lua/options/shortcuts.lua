i_map('jk', '<Esc>') -- jk to escape
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
-- n_map('<leader>hl', ':echo "use unimpaired `yoc` instead"<CR>') -- toggle current line highlighting
c_map('fff', "f\\(des\\|con\\|it\\)<CR>") -- Find focus `:fff`
c_map('xxx', "x\\(des\\|con\\|it\\)<CR>") -- Find focus `:fff`
n_map('gp', "`[v`]`") -- reselect pasted text: https://vimtricks.com/p/reselect-pasted-text/

-- close window with q
n_map(';q', ':q<CR>')
n_map(';Q', ':q!<CR>')
n_map('<leader>t', ':quit<CR>')

-- simplify tabbed navigation with shift
n_map('<S-H>', 'gT')
n_map('<S-L>', 'gt')

-- Open in Marked 2
vim.keymap.set('n', '<leader>md', ":silent !open -a Marked\\ 2.app '%:p'<cr>", { desc = "Open in Marked 2" })

-- Theme switching
vim.keymap.set('n', '<leader>tD', ":let &background='dark' | :silent !kitty @ set-colors --all ~/.config/kitty/themes/solarized-dark.conf && kitty @ set-font-size 22 <CR> | <CR>", { desc = "Dark pair" })
vim.keymap.set('n', '<leader>tL', ":let &background='light' | :silent !kitty @ set-colors --all ~/.config/kitty/themes/solarized-light.conf && kitty @ set-font-size 22 <CR> | <CR>", { desc = "Light pair" })
vim.keymap.set('n', '<leader>td', ":let &background='dark' | :silent !kitty @ set-colors --all ~/.config/kitty/themes/solarized-dark.conf && kitty @ set-font-size 14 <CR> | <CR>", { desc = "Dark solo" })
vim.keymap.set('n', '<leader>tl', ":let &background='light' | :silent !kitty @ set-colors --all ~/.config/kitty/themes/solarized-light.conf && kitty @ set-font-size 14 <CR> | <CR>", { desc = "Light solo" })

-- Open notes for current project
vim.keymap.set('n', '<leader>do', ":tab drop tmp/notes.md<CR>", { desc = "Project notes" })

-- Surround puts then position cursor inside qutoes
i_map('ppp', 'puts "*"*100<CR>puts ""<CR>puts "*"*100<CR><esc>kkwa')

-- Copy current file path (from git root) to clipboard
vim.keymap.set('n', '<leader>cfn', ':let @+ = substitute(expand("%:p"), fnamemodify(trim(system("git rev-parse --show-toplevel")), ":h") . "/", "", "")<CR>:echo "Copied: " . @+<CR>', { desc = "Copy file path" })
