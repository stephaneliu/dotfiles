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

n_map('<leader>m', ":silent !open -a Marked\\ 2.app '%:p'<cr>")

n_map('<leader>dpair', ":let &background='dark' | :silent !kitty @ set-colors --all ~/.config/kitty/themes/solarized-dark.conf && kitty @ set-font-size 22 <CR> | <CR>")
n_map('<leader>lpair', ":let &background='light' | :silent !kitty @ set-colors --all ~/.config/kitty/themes/solarized-light.conf && kitty @ set-font-size 22 <CR> | <CR>")
n_map('<leader>dsolo', ":let &background='dark' | :silent !kitty @ set-colors --all ~/.config/kitty/themes/solarized-dark.conf && kitty @ set-font-size 14 <CR> | <CR>")
n_map('<leader>lsolo', ":let &background='light' | :silent !kitty @ set-colors --all ~/.config/kitty/themes/solarized-light.conf && kitty @ set-font-size 14 <CR> | <CR>")

-- Open notes for current project
n_map('<leader>do', ":tab drop tmp/notes.md<CR>")

-- Surround puts then position cursor inside qutoes
i_map('ppp', 'puts "*"*100<CR>puts ""<CR>puts "*"*100<CR><esc>kkwa')
