return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    input = {
      enabled = true,
      win = {
        relative = "editor",
        row = math.floor(vim.o.lines / 2) - 1,
        backdrop = false,
      },
    },
    picker = { enabled = true },
  },
}
