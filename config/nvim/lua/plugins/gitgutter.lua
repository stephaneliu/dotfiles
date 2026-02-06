return {
  'airblade/vim-gitgutter',
  enabled = true,
  event = "VeryLazy",
  keys = {
    { "<leader>ggh", "<CMD>GitGutterLineHighlightsToggle<CR>", desc = "Toggle highlights" },
    { "<leader>ggf", "<CMD>GitGutterFold<CR>", desc = "Fold hunks" },
    { "<leader>ggn", "<Plug>(GitGutterNextHunk)", desc = "Next hunk" },
    { "<leader>ggp", "<Plug>(GitGutterPrevHunk)", desc = "Prev hunk" },
  },
  init = function()
    vim.g.gitgutter_highlight_lines = 1

    vim.api.nvim_exec("highlight clear SignColumn", false)
    vim.api.nvim_exec("highlight GitGutterAdd guifg=#009900 ctermfg=2 ctermbg=0", false)
    vim.api.nvim_exec("highlight GitGutterChange guifg=#bbbb00 ctermfg=3 ctermbg=0", false)
    vim.api.nvim_exec("highlight GitGutterDelete guifg=#ff2222 ctermfg=1 ctermbg=0", false)
  end
}
