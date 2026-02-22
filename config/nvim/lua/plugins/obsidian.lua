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
      note_mappings = {
        new = '<C-n>',
        insert_link = '<C-l>',
      },
      tag_mappings = {
        tag_note = '<C-t>',
        insert_tag = '<C-x>',
      },
    },
    sort_by = 'modified',
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    new_notes_location = 'current_dir',
    open_notes_in = 'vsplit',
    note_id_func = function(title)
      if title ~= nil then
        return title
      else
        local suffix = ""
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
        return suffix
      end
    end,
    wiki_link_func = function(opts)
      return string.format('[[%s]]', opts.path)
    end,
    ui = {
      enable = false,
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
      },
    },
  },
  keys = {
    { '<leader>on', '<CMD>ObsidianNew<CR>', desc = 'New note' },
    { '<leader>oo', '<CMD>ObsidianOpen<CR>', desc = 'Open in Obsidian' },
    { '<leader>os', '<CMD>ObsidianSearch<CR>', desc = 'Search notes' },
    { '<leader>oq', '<CMD>ObsidianQuickSwitch<CR>', desc = 'Quick switch' },
    { '<leader>ob', '<CMD>ObsidianBacklinks<CR>', desc = 'Backlinks' },
    { '<leader>ot', '<CMD>vsplit | ObsidianToday<CR>', desc = 'Today note' },
    { '<leader>oy', '<CMD>vsplit | ObsidianYesterday<CR>', desc = 'Yesterday note' },
    { '<leader>ol', '<CMD>ObsidianLinks<CR>', desc = 'Links' },
    { '<leader>of', '<CMD>ObsidianFollowLink<CR>', desc = 'Follow link' },
    { '<leader>ox', '<CMD>ObsidianToggleCheckbox<CR>', desc = 'Toggle checkbox' },
  },
}
