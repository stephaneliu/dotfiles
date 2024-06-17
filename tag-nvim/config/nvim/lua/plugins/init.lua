local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
--
Plug('ecomba/vim-ruby-refactoring')
Plug('rking/ag.vim')

-- Ruby
Plug('tpope/vim-rails')

-- Git
Plug('christoomey/vim-conflicted')
Plug('tpope/vim-fugitive')
Plug('mattn/gist-vim')
--
vim.call('plug#end')

require("plugins.ag")
require("plugins.rails")
require("plugins.standardrb")
require("plugins.conflicted")
