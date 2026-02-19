return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/Documents/Obsidian/Personal',
      },
    },
    picker = {
      name = 'telescope.nvim',
      opts = {
        search = {
          default_text = '.',
        },
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    new_notes_location = 'current_dir',
    open_notes_in = 'vsplit',
    wiki_link_func = function(opts)
      return string.format('[[%s]]', opts.path)
    end,
  },
  keys = {
    { '<leader>on', '<CMD>ObsidianNew<CR>', desc = 'New note' },
    { '<leader>oo', '<CMD>ObsidianOpen<CR>', desc = 'Open in Obsidian' },
    { '<leader>os', '<CMD>ObsidianSearch<CR>', desc = 'Search notes' },
    { '<leader>oq', '<CMD>ObsidianQuickSwitch<CR>', desc = 'Quick switch' },
    { '<leader>ob', '<CMD>ObsidianBacklinks<CR>', desc = 'Backlinks' },
    { '<leader>ot', '<CMD>ObsidianToday<CR>', desc = 'Today note' },
    { '<leader>oy', '<CMD>ObsidianYesterday<CR>', desc = 'Yesterday note' },
    { '<leader>ol', '<CMD>ObsidianLinks<CR>', desc = 'Links' },
    { '<leader>of', '<CMD>ObsidianFollowLink<CR>', desc = 'Follow link' },
  },
}