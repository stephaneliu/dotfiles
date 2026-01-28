return {
  'Yggdroot/indentLine',
  enabled = true,
  init = function()
    vim.g.indentLine_char = '▏'
    n_map('<leader>il', ':IndentLinesToggle<CR>')
    vim.g.indentLine_bufTypeExclude = {'terminal', 'nofile'}
    vim.g.indentLine_fileTypeExclude = {'terminal', 'snacks_terminal', 'snacks_win'}
  end
}
