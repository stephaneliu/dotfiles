-- ]x next conflict
-- [x previous conflict
return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  opts = function()
    local actions = require('diffview.actions')
    return {
      keymaps = {
        view = {
          { 'n', '<leader>co', actions.conflict_choose('ours'), { desc = 'Choose LEFT' } },
          { 'n', '<leader>ct', actions.conflict_choose('theirs'), { desc = 'Choose RIGHT' } },
          { 'n', '<leader>cb', actions.conflict_choose('base'), { desc = 'Choose BASE' } },
          { 'n', '<leader>ca', actions.conflict_choose('all'), { desc = 'Choose ALL' } },
          { 'n', '<leader>cx', actions.conflict_choose('none'), { desc = 'Choose NONE' } },
        },
        file_panel = {
          { 'n', '<leader>co', actions.conflict_choose_all('ours'), { desc = 'Choose LEFT (all)' } },
          { 'n', '<leader>ct', actions.conflict_choose_all('theirs'), { desc = 'Choose RIGHT (all)' } },
          { 'n', '<leader>cb', actions.conflict_choose_all('base'), { desc = 'Choose BASE (all)' } },
          { 'n', '<leader>ca', actions.conflict_choose_all('all'), { desc = 'Choose ALL (all)' } },
          { 'n', '<leader>cx', actions.conflict_choose_all('none'), { desc = 'Choose NONE (all)' } },
        },
      },
    }
  end,
}
