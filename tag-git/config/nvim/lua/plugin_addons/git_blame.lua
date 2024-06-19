return {
  'f-person/git-blame.nvim',
  event = "BufEnter",
  keys = {
    { "<leader>b", "<CMD>GitBlameToggle<CR>" }
  }
}
