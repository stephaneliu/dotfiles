return {
  'alvan/vim-closetag',
  enabled = true,
  init = function()
    vim.g.closetag_filenames = '*.html.erb'
  end
}
