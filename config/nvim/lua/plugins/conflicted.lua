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

    -- Suppress guitablabel error in terminal nvim
    local orig_conflicted = vim.fn.exists(':Conflicted') == 2 and vim.cmd.Conflicted
    vim.api.nvim_create_user_command('Conflicted', function()
      pcall(function()
        vim.cmd('silent! call conflicted#Conflicted()')
      end)
    end, { force = true })
  end
}
