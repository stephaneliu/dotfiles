return {
  'overcache/NeoSolarized',
  enabled = true,
  lazy = false,
  priority = 1000, -- make sure to load this before all other plugins
  init = function()
    vim.cmd('syntax enable')
    vim.o.termguicolors = true
    -- When I change background using vim shortcut it should set an enviornmental variable that can be
    -- read here when applying the background
    vim.o.background = 'dark'
    vim.cmd([[colorscheme NeoSolarized]])
  end
}
