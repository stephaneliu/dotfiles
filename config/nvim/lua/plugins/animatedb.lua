return {
  'alanfortlink/animatedbg.nvim',
  config = function ()
    require("animatedbg-nvim").setup({
        fps = 120 -- default
    })
  end,
  keys = {
    {
      "<leader>animatrix",
      function()
        local animatedbg = require("animatedbg-nvim")
        animatedbg.play({ animation = "matrix", duration = 5 }) -- fireworks | matrix | demo
        -- animatedbg.play({ animation = "matrix", duration = 20 }) -- some support duration
        -- animatedbg.play({ animation = "fireworks", duration = 500, time_between_shots = 0.1 })
        -- animatedbg.stop_all() -- if you don't want to wait
      end
    },
    {
      "<leader>anifire",
      function()
        local animatedbg = require("animatedbg-nvim")
        animatedbg.play({ animation = "fireworks", duration = 5, time_between_shots = 0.1 })
      end
    },
    {
      "<leader>anistop",
      function()
        local animatedbg = require("animatedbg-nvim")
        animatedbg.stop_all()
      end
    },
  },
}
