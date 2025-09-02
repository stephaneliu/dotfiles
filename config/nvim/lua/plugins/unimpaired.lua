return {
  'tpope/vim-unimpaired',
  enabled = true,
  -- Display relative line numbers
  init = function()
    vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "BufRead", "BufNewFile"}, {
      pattern = "*",
      callback = function()
        vim.wo.relativenumber = true
      end
    })
  end
}
