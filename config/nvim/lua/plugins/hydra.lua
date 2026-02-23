return {
  "nvimtools/hydra.nvim",
  event = "VeryLazy",
  config = function()
    local Hydra = require("hydra")

    Hydra({
      name = "Window Resize",
      mode = "n",
      body = "<C-w>",
      heads = {
        { "+", "<C-w>+" },
        { "-", "<C-w>-" },
        { "<", "<C-w><" },
        { ">", "<C-w>>" },
        { "=", "<C-w>=", { exit = true } },
        { "<Esc>", nil, { exit = true } },
      },
    })
  end,
}