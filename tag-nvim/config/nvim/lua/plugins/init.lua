local vim = vim
local Plug = vim.fn['plug#']


-- Load plugins
vim.call('plug#begin')
--
Plug('rking/ag.vim')
Plug( 'xolox/vim-session')         -- Manage sessions :SaveSession / OpenSession
  Plug('xolox/vim-misc')           -- Dependency of vim-session

-- Ruby
Plug('tpope/vim-endwise')          -- auto add endfunction in Ruby
Plug('tpope/vim-rails')
Plug('ecomba/vim-ruby-refactoring')

-- Git
Plug('christoomey/vim-conflicted')
Plug('tpope/vim-fugitive')
Plug('ruanyl/vim-gh-line')         -- A Vim plugin that opens a link to the current line on GitHub
Plug('mattn/gist-vim')
Plug('tpope/vim-git')
Plug('airblade/vim-gitgutter')
Plug('tveskag/nvim-blame-line')

--
vim.call('plug#end')
-- End load plugins


-- Plugin configs
require("plugins.ag")
require("plugins.session")

-- Ruby
require("plugins.rails")
require("plugins.standardrb")

-- Git
require("plugins.conflicted")
require("plugins.gh_line")
require("plugins.gist")
require("plugins.gitgutter")
require("plugins.nvim_blame_line")
