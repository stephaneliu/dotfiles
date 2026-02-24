return {
  "swaits/zellij-nav.nvim",
  lazy = true,
  event = "VeryLazy",
  keys = {
    { "<c-h>", "<cmd>ZellijNavigateLeft<cr>", desc = "navigate left" },
    { "<c-j>", "<cmd>ZellijNavigateDown<cr>", desc = "navigate down" },
    { "<c-k>", "<cmd>ZellijNavigateUp<cr>", desc = "navigate up" },
    { "<c-l>", "<cmd>ZellijNavigateRight<cr>", desc = "navigate right" },
  },
  opts = {},
}
