return {
  'overcache/NeoSolarized',
  lazy = false,
  priority = 1000, -- make sure to load this before all other plugins
  init = function()
    vim.cmd('syntax enable')
    vim.o.termguicolors = true
    vim.o.background = 'dark'
    vim.cmd([[colorscheme NeoSolarized]])
  end
}
