return {
  'justinmk/vim-sneak',
  keys = {
    { 'f', '<Plug>Sneak_s' },
    { 'F', '<Plug>Sneak_S' },
  },
  init = function()
    vim.g['sneak#s_next'] = 1
    vim.g['sneak#use_ic_scs'] = 1
  end
}
