return {
  'Yggdroot/indentLine',
  enabled = true,
  init = function()
    vim.g.indentLine_char = '▏'
    n_map('<leader>il', ':IndentLinesToggle<CR>')
  end
}
