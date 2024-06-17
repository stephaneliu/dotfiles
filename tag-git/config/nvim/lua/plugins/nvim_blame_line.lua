n_map("<leader>b", ":ToggleBlameLine<CR>")

vim.api.nvim_exec([[
  autocmd BufEnter * EnableBlameLine
]], false)
