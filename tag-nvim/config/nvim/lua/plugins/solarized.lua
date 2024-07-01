return {
  {
    -- "overcache/NeoSolarized",
    -- "shaunsingh/solarized.nvim",
    "maxmx03/solarized.nvim",
    config = function()
      vim.o.background = "dark"
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
    },
  },
}
