return {
  'f-person/git-blame.nvim',
  enabled = true,
  event = "BufEnter",
  keys = {
    { "<leader>b", "<CMD>GitBlameToggle<CR>" }
  }
}
