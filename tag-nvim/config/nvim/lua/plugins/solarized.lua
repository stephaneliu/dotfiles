return {
  {
    "overcache/NeoSolarized",
    init = function()
      vim.o.termguicolors = true
      vim.o.background = "dark"
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "NeoSolarized",
    },
  },
}
