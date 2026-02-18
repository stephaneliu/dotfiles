-- Code annotation sessions
-- jump_to_location = { "<CR>", "gd" }, -- in side panel
-- next_annotation = "]a",              -- in side panel
-- prev_annotation = "[a",              -- in side panel
return {
  'zion-off/mole.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    keys = {
      annotate = '<leader>aa',
      start_session = '<leader>as',
      stop_session = '<leader>aq',
      resume_session = '<leader>ar',
      toggle_window = '<leader>aw',
    },
  },
}
