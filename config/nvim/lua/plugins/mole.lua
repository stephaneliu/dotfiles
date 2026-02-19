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
    session_name = function()
      local branch = vim.fn.system('git branch --show-current 2>/dev/null'):gsub('%s+', '')
      if branch == '' then
        branch = 'no-branch'
      end
      return os.date('%Y%m%d_%H%M%S') .. '_' .. branch
    end,
  },
}
