return {
  "folke/which-key.nvim",
  enabled = true,
  event = "VeryLazy",
  opts = {
    delay = 300,
    spec = {
      { "<leader>c", group = "AI/Code" },
      { "<leader>co", group = "CopilotChat" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>gg", group = "GitGutter" },
      { "<leader>gi", group = "Git Inline" },
      { "<leader>h", group = "Harpoon/Marks" },
      { "<leader>ht", group = "Haunt" },
      { "<leader>a", group = "Align", mode = "v" },
      { "<leader>A", group = "Animations" },
      { "<leader>r", group = "RSpec" },
      { "<leader>t", group = "Theme" },
    },
  },
}