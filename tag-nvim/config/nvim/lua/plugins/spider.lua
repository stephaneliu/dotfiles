return {
  'chrisgrieser/nvim-spider',
  enabled = true,
  config = function()
    require('spider').setup {
      skipInsignificantPunctuation = false,
      consistentOperatorPending = true,
      subwordMovement = true,
    }
  end,
  keys = {
    { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = {"n", "o", "x"} },
    { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = {"n", "o", "x"} },
    { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = {"n", "o", "x"} }
  }
}
