return {
  'aikhe/wrapped.nvim',
  dependencies = { 'nvzone/volt' },
  cmd = { 'WrappedNvim' },
  keys = {
    { '<leader>W', '<CMD>WrappedNvim<CR>', desc = 'Wrapped stats' },
  },
  opts = {
    path = vim.fn.expand('~/.dotfiles'),
  },
}