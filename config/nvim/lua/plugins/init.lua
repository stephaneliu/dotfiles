local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
--
Plug('rking/ag.vim')
Plug('tpope/vim-rails')
--
vim.call('plug#end')

require("plugins.ag")
require("plugins.rails")
-- require("plugins.")
