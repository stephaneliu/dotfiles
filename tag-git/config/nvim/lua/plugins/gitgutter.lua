return {
  'airblade/vim-gitgutter',
  keys = {
    { "<leader>ggh", "<CMD>GitGutterLineHighlightsToggle<CR>" },
    { "<leader>ggf", "<CMD>GitGutterFold<CR>" },
    { "]h", "<Plug>(GitGutterNextHunk)" },
    { "[h", "<Plug>(GitGutterPrevHunk)" },
  },
  init = function()
    vim.g.gitgutter_highlight_lines = 1

    vim.api.nvim_exec("highlight clear SignColumn", false)
    vim.api.nvim_exec("highlight GitGutterAdd guifg=#009900 ctermfg=2 ctermbg=0", false)
    vim.api.nvim_exec("highlight GitGutterChange guifg=#bbbb00 ctermfg=3 ctermbg=0", false)
    vim.api.nvim_exec("highlight GitGutterDelete guifg=#ff2222 ctermfg=1 ctermbg=0", false)
  end
}
