vim.g.mapleader = ","
vim.o.swapfile = false
vim.o.incsearch = true
vim.opt.clipboard:append("unnamedplus")
vim.cmd([[colorscheme desert]])

vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/lazy/kitty-scrollback.nvim')
require('kitty-scrollback').setup({})
