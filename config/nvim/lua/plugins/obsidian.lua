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
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      -- Human readable timestamp in the format to the second
      return os.date('%Y%m%d%H%M%S') .. "-" .. suffix
    end,
    wiki_link_func = function(opts)
      return string.format('[[%s]]', opts.path)
    end,
    ui = {
      enable = false,
      update_debounce = 200,
      checkboxes = {},
      bullets = {},
      external_link_icon = {},
      reference_text = {},
      highlight_text = {},
      tags = {},
      block_ids = {},
      hl_groups = {},
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
