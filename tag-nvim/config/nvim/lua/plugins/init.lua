local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
--
Plug('ecomba/vim-ruby-refactoring')
Plug('rking/ag.vim')

-- Ruby
Plug('tpope/vim-endwise')          -- auto add endfunction in Ruby
Plug('tpope/vim-rails')

-- Git
Plug('christoomey/vim-conflicted')
Plug('tpope/vim-fugitive')
Plug('mattn/gist-vim')
Plug('tpope/vim-git')

--
vim.call('plug#end')

-- Plugin configs
require("plugins.ag")

-- Ruby
require("plugins.rails")
require("plugins.standardrb")

-- Git
require("plugins.conflicted")
require("plugins.gist")
