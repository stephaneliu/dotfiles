return {
  "ThePrimeagen/harpoon",
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
      end
    },
    {
      "<leader>hl",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "quick menu"
    }
  },
}
