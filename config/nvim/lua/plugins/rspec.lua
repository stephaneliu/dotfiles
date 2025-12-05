return {
  'thoughtbot/vim-rspec',
  enabled = true,
  init = function()
    vim.g.rspec_command = 'execute "!dip rspec " . substitute("{spec}", "^.*/spec/", "spec/", "")'
  end,
  keys = {
    { "<leader>rfile", ":call RunCurrentSpecFile()<CR>" },
    { "<leader>rnear", ":call RunNearestSpec()<CR>" },
  }
}
