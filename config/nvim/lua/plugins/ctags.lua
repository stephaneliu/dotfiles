return {
  "ctags-config",
  virtual = true,
  config = function()
    -- Look for .tags in current directory and parents, fallback to home directory
    vim.opt.tags = "./.tags;,~/.tags"
  end,
}