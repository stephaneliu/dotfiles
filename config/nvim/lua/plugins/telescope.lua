return {
  "nvim-telescope/telescope.nvim",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        preview = {
          treesitter = false,
        },
      },
    })

    telescope.load_extension("fzf")
  end,
  keys = {
    { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Fuzzy find files in cwd" },
    { "<leader>fw", "<CMD>Telescope live_grep<CR>", desc = "Find string in cwd" },
    { "<leader>fr", "<CMD>Telescope oldfiles<CR>", desc = "Fuzzy find recent files" },
    { "<leader>fc", "<CMD>Telescope grep_string<CR>", desc = "Find string under cursor in cwd" },
    { "<leader>fn", "<CMD>Telescope notify<CR>", desc = "Find notifications" },
  }
}
