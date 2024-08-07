return {
  'christoomey/vim-conflicted',
  enabled = true,
  init = function()
    vim.o.statusline = vim.o.statusline .. "%{ConflictedVersion()}"
    -- Resolve and move to next conflicted file
    n_map("]m", ":GitNextConflict<cr>")
    vim.g.diffget_local_map = 'gl'
    vim.g.diffget_upstream_map = 'gu'
  end
}
