vim.o.showcmd = false
vim.o.number = true  -- forces ruler to be visible (vice toggle)
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.autoindent = true
vim.o.scrolloff = 3
vim.o.cursorline = true
vim.o.statusline = "1"
vim.o.laststatus = 2
vim.o.statusline = "%<%f\\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\\ %P"
-- set statusline=1

-- http://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character
-- use yol (unimpaired) to toggle list
vim.o.listchars = "eol:$,tab:>-,trail:~,extends:>,precedes:<"
vim.o.numberwidth = 3
vim.o.colorcolumn = "120" -- set a highlighted column at the 120th character on line
vim.o.textwidth = 120   -- wrap text at 120 characters
vim.o.wrapmargin = 2    -- command to actually wrap on the display

-- vim.o.conceallevel = 0 -- Prevents markdown from being hidden - i.e. expands hyperlinks. Default: 0

n_map("<leader>ql", ":resize 40<CR>") -- (q)uickfix (l)arge
n_map("<leader>qs", ":resize 90<CR>") -- (q)uickfix (s)mall
