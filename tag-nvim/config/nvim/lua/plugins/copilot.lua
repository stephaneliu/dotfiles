return {
  'github/copilot.vim',
  enabled = true,
  init = function()
    i_map('<C-N>', '<Plug>(copilot-next)')
    i_map('<C-P>', '<Plug>(copilot-previous)')
  end
}
