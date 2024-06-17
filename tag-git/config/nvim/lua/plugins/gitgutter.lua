vim.g.gitgutter_highlight_lines = 1
n_map("<leader>ggh", ":GitGutterLineHighlightsToggle<CR>")
n_map("<leader>ggf", ":GitGutterFold<CR>")

vim.api.nvim_exec("highlight clear SignColumn", false)
vim.api.nvim_exec("highlight GitGutterAdd guifg=#009900 ctermfg=2 ctermbg=0", false)
vim.api.nvim_exec("highlight GitGutterChange guifg=#bbbb00 ctermfg=3 ctermbg=0", false)
vim.api.nvim_exec("highlight GitGutterDelete guifg=#ff2222 ctermfg=1 ctermbg=0", false)
