vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.o.nocompatible = true
vim.o.swapfile = false
vim.o.history = 10000
vim.o.incsearch = true
vim.o.timeout = false
vim.o.timeoutlen = 100
vim.o.ttimeout = true
vim.o.ff=unix
vim.o.showcmd = true
vim.o.number = true -- show line numbers
vim.o.ruler = true  -- show the cursor position all the time
vim.o.scrolloff = 3 -- number of visible lines above and below cursor

USER = os.getenv("USER")

vim.o.backup = true
vim.o.writebackup = true
vim.opt.backupdir = "/Users/" .. USER .. "/.nvim-backup"
vim.o.backupskip = "/tmp/*,/private/tmp/*"   -- setting backupskip to allow crontab -e to use vim

vim.o.undofile = true -- " Presistent undo
vim.opt.undodir = "/Users/" .. USER .. "/.nvim-undo"

vim.o.autoindent = true
vim.o.copyindent = true
vim.o.showmatch = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.foldenable = false
vim.o.foldmethod = "indent"

vim.o.mouse = ""
