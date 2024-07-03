vim.opt.signcolumn = "yes" -- otherwise it bounces in and out
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  group = vim.api.nvim_create_augroup("RubyLSP", { clear = true }), -- also this is not /needed/ but it's good practice
  callback = function()
    vim.lsp.start {
      name = "standard",
      -- cmd = { "/Users/stephane.liu/.local/share/mise/installs/ruby/latest/bin/standardrb", "--lsp" },
      cmd = { "standardrb", "--lsp" },
      on_attach = function() end,
    }
  end,
})
