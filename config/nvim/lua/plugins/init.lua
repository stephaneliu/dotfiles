local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
--
Plug('ecomba/vim-ruby-refactoring')
Plug('rking/ag.vim')

-- Ruby
Plug('tpope/vim-rails')

-- Git
Plug('tpope/vim-fugitive')
--
vim.call('plug#end')

require("plugins.ag")
require("plugins.rails")
require("plugins.standardrb")
