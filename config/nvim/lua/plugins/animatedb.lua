return {
  'alanfortlink/animatedbg.nvim',
  config = function ()
    require("animatedbg-nvim").setup({
        fps = 120 -- default
    })
  end,
  keys = {
    {
      "<leader>Am",
      function()
        local animatedbg = require("animatedbg-nvim")
        animatedbg.play({ animation = "matrix", duration = 5 })
      end,
      desc = "Matrix (5s)"
    },
    {
      "<leader>AM",
      function()
        local animatedbg = require("animatedbg-nvim")
        animatedbg.play({ animation = "matrix", duration = 500 })
      end,
      desc = "Matrix (long)"
    },
    {
      "<leader>Af",
      function()
        local animatedbg = require("animatedbg-nvim")
        animatedbg.play({ animation = "fireworks", duration = 5, time_between_shots = 0.1 })
      end,
      desc = "Fireworks (5s)"
    },
    {
      "<leader>AF",
      function()
        local animatedbg = require("animatedbg-nvim")
        animatedbg.play({ animation = "fireworks", duration = 500, time_between_shots = 0.1 })
      end,
      desc = "Fireworks (long)"
    },
    {
      "<leader>As",
      function()
        local animatedbg = require("animatedbg-nvim")
        animatedbg.stop_all()
      end,
      desc = "Stop all"
    },
  },
}
