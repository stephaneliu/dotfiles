return {
  'github/copilot.vim',
  init = function()
    i_map('<C-N>', '<Plug>(copilot-next)')
    i_map('<C-P>', '<Plug>(copilot-previous)')
  end
}
