return {
  -- A Vim plugin that opens a link to the current line on GitHub
  -- <leader>gh blob view
  -- <leader>gb blame view
  -- <leader>go repo view
  'ruanyl/vim-gh-line',
  enabled = true,
  init = function()
    vim.g.gh_use_cononical = 1
    vim.g.gh_line_map = '<leader>Gh'
    vim.g.gh_line_blame_map = '<leader>Gb'
    vim.g.gh_repo_map = '<leader>Go'
  end
}
