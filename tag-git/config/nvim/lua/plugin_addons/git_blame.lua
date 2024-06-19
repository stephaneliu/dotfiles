return {
  'f-person/git-blame.nvim',
  priority = 1000, -- make sure to load this before all other plugins
  keys = {
    { "<leader>b", "<CMD>GitBlameToggle<CR>", mode = { "n" } }
  }
}
