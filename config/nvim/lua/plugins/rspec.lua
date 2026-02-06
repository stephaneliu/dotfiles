return {
  'thoughtbot/vim-rspec',
  enabled = true,
  init = function()
    vim.g.rspec_command = 'execute "!dip rspec " . substitute("{spec}", "^.*/spec/", "spec/", "")'
  end,
  keys = {
    { "<leader>rf", ":call RunCurrentSpecFile()<CR>", desc = "Run spec file" },
    { "<leader>rn", ":call RunNearestSpec()<CR>", desc = "Run nearest spec" },
  }
}
