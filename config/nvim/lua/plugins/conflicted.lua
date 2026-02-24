return {
  'christoomey/vim-conflicted',
  enabled = true,
  dependencies = { 'tpope/vim-fugitive' },
  cmd = { 'Conflicted', 'GitNextConflict' },
  init = function()
    vim.g.diffget_local_map = 'gl'
    vim.g.diffget_upstream_map = 'gu'
  end,
  config = function()
    vim.o.statusline = vim.o.statusline .. "%{ConflictedVersion()}"
    n_map("]m", ":GitNextConflict<cr>")
  end
}
