return {
  "ThePrimeagen/harpoon",
  enabled = true,
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    require("harpoon"):setup({})
  end,
  keys = {
    {
      "<leader>ha",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Add current file to harpoon"
    },
    {
      "<leader>hl",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Display harpooned menu"
    }
  },
}
