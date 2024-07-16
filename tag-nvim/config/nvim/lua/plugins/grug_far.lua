return {
  'MagicDuck/grug-far.nvim',
  enabled = true,
  config = function()
    require('grug-far').setup({
      preview = {
        border = 'rounded',
      },
    })
  end,
  keys = {
    { "\\", "<cmd>GrugFar<CR>", { noremap = true } },
  },
}
