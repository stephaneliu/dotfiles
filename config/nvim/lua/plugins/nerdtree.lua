return {
  'scrooloose/nerdtree',
  enabled = true,
  init = function()
    vim.g.NERDTreeShowHidden = 1
    vim.g.NERDTreeQuitOnOpen = 1
    vim.g.NERDTreeWinPos = "right"
    n_map('<leader>d', ':NERDTreeFind<CR>')
  end
}
