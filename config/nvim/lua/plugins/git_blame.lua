return {
  'f-person/git-blame.nvim',
  enabled = true,
  event = "BufEnter",
  keys = {
    { "<leader>gib", "<CMD>GitBlameToggle<CR>", desc = "Toggle inline blame" }
  }
}
