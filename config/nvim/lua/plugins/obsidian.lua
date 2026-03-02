return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    -- Custom cmp source for natural language dates triggered by @
    local cmp = require('cmp')
    local date_source = {}

    date_source.new = function()
      return setmetatable({}, { __index = date_source })
    end

    date_source.get_trigger_characters = function()
      return { '@' }
    end

    date_source.complete = function(self, request, callback)
      if vim.bo.filetype ~= 'markdown' then
        callback({ items = {}, isIncomplete = false })
        return
      end

      -- Match @... pattern, capturing everything after @
      local line = request.context.cursor_before_line
      local at_match = line:match('@([%w%s]*)$')
      if not at_match then
        callback({ items = {}, isIncomplete = false })
        return
      end

      local input = string.lower(at_match)

      local function make_date(days_offset)
        return os.date('%Y-%m-%d', os.time() + (days_offset * 86400))
      end

      local function make_month_date(months_offset)
        local now = os.date('*t')
        now.month = now.month + months_offset
        return os.date('%Y-%m-%d', os.time(now))
      end

      local date_expressions = {
        { label = 'today', date = make_date(0) },
        { label = 'tomorrow', date = make_date(1) },
        { label = 'yesterday', date = make_date(-1) },
        { label = 'next week', date = make_date(7) },
        { label = 'last week', date = make_date(-7) },
        { label = 'next month', date = make_month_date(1) },
        { label = 'last month', date = make_month_date(-1) },
      }

      -- Days: up to 30
      for i = 2, 30 do
        table.insert(date_expressions, { label = i .. ' days ago', date = make_date(-i) })
        table.insert(date_expressions, { label = i .. ' days from now', date = make_date(i) })
      end

      -- Weeks: up to 12
      for i = 2, 12 do
        table.insert(date_expressions, { label = i .. ' weeks ago', date = make_date(-i * 7) })
        table.insert(date_expressions, { label = i .. ' weeks from now', date = make_date(i * 7) })
      end

      -- Months: up to 12
      for i = 2, 12 do
        table.insert(date_expressions, { label = i .. ' months ago', date = make_month_date(-i) })
        table.insert(date_expressions, { label = i .. ' months from now', date = make_month_date(i) })
      end

      -- Calculate the start position of @ to replace it
      local at_start = #line - #at_match - 1  -- position of @

      local items = {}
      for _, expr in ipairs(date_expressions) do
        if input == '' or expr.label:find(input, 1, true) then
          table.insert(items, {
            label = '@' .. expr.label,
            filterText = '@' .. expr.label,
            kind = cmp.lsp.CompletionItemKind.Value,
            documentation = 'Link to ' .. expr.date,
            textEdit = {
              newText = '[[daily-notes/' .. expr.date .. ']]',
              range = {
                start = { line = request.context.cursor.row - 1, character = at_start },
                ['end'] = { line = request.context.cursor.row - 1, character = request.context.cursor.col - 1 },
              },
            },
          })
        end
      end

      callback({ items = items, isIncomplete = false })
    end

    cmp.register_source('obsidian_dates', date_source.new())

    -- Add source to cmp for markdown files
    cmp.setup.filetype('markdown', {
      sources = cmp.config.sources({
        { name = 'obsidian' },
        { name = 'obsidian_dates' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
      }),
    })

    require('obsidian').setup({
      workspaces = {
        {
          name = 'personal',
          path = '~/Documents/Obsidian/Personal',
        },
      },
      daily_notes = {
        folder = 'daily-notes',
        date_format = '%Y-%m-%d',
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
          local suffix = ''
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
          return suffix
        end
      end,
      wiki_link_func = function(opts)
        return string.format('[[%s]]', opts.path)
      end,
      note_path_func = function(spec)
        local path = spec.dir / tostring(spec.id)
        -- Route date-formatted notes (YYYY-MM-DD) to daily-notes folder
        if tostring(spec.id):match('^%d%d%d%d%-%d%d%-%d%d$') then
          path = spec.dir / 'daily-notes' / tostring(spec.id)
        end
        return path:with_suffix('.md')
      end,
      ui = {
        enable = false,
        checkboxes = {
          [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
          ['x'] = { char = '', hl_group = 'ObsidianDone' },
        },
      },
    })
  end,
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
