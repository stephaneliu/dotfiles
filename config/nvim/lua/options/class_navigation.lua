-- Class navigation via ctags for Ruby and React filetypes
-- Provides gd keymap for jump-to-class and <leader>gc for fuzzy class search

-- Tag kinds to include in class picker (from --kinds-Ruby=cfm)
-- c = class, m = module (excluding f = function/method)
local CLASS_TAG_KINDS = { c = true, m = true }

-- Open telescope picker for fuzzy class/component search
-- Filters tags to only show classes and modules (not methods)
-- Uses custom picker with entry filtering for performance
local function telescope_tags_picker(default_text)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local entry_display = require("telescope.pickers.entry_display")

  -- Read all tags and filter to class/module kinds
  local tags_files = vim.fn.tagfiles()
  if #tags_files == 0 then
    vim.notify("No tags file found. Run :CtagsRegen first.", vim.log.levels.WARN)
    return
  end

  local entries = {}
  for _, tags_file in ipairs(tags_files) do
    local file = io.open(tags_file, "r")
    if file then
      for line in file:lines() do
        -- Skip comment lines (start with !)
        if not line:match("^!") then
          -- Parse ctags format: tagname<TAB>filename<TAB>pattern;"<TAB>kind<TAB>...
          local tag_name, filename, pattern, kind = line:match("^([^\t]+)\t([^\t]+)\t([^\t]+)\t(%a)")
          if tag_name and filename and kind and CLASS_TAG_KINDS[kind] then
            -- Extract line number from pattern if available (e.g., /^class Foo$/;" or 42;")
            local line_num = pattern:match("^(%d+);") or "1"
            table.insert(entries, {
              name = tag_name,
              filename = filename,
              line = tonumber(line_num) or 1,
              kind = kind,
              pattern = pattern,
            })
          end
        end
      end
      file:close()
    end
  end

  if #entries == 0 then
    vim.notify("No class/module tags found", vim.log.levels.WARN)
    return
  end

  -- Create display formatter
  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = 40 },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    return displayer({
      entry.value.name,
      { entry.value.filename, "Comment" },
    })
  end

  pickers
    .new({}, {
      prompt_title = "Classes & Modules",
      default_text = default_text or "",
      finder = finders.new_table({
        results = entries,
        entry_maker = function(entry)
          return {
            value = entry,
            display = make_display,
            ordinal = entry.name .. " " .. entry.filename,
            filename = entry.filename,
            lnum = entry.line,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = conf.file_previewer({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            vim.cmd.edit(vim.fn.fnameescape(selection.filename))
            vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
          end
        end)
        return true
      end,
    })
    :find()
end

-- Open telescope picker with pre-fetched tag matches
-- Shows file path and preview pane with definition context
local function open_tag_picker(tag_name, matches)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local entry_display = require("telescope.pickers.entry_display")

  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = 40 },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    return displayer({
      entry.value.name,
      { entry.value.filename, "Comment" },
    })
  end

  pickers
    .new({}, {
      prompt_title = "Tag: " .. tag_name,
      finder = finders.new_table({
        results = matches,
        entry_maker = function(match)
          return {
            value = match,
            display = make_display,
            ordinal = match.name .. " " .. match.filename,
            filename = match.filename,
            lnum = match.cmd and tonumber(match.cmd:match("^(%d+)")) or 1,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = conf.file_previewer({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            vim.cmd.edit(vim.fn.fnameescape(selection.filename))
            if selection.lnum then
              vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
            end
          end
        end)
        return true
      end,
    })
    :find()
end

-- Extract word under cursor and prepare it for tag lookup
-- Handles Ruby namespace syntax: Admin::UserService -> Admin.UserService (ctags format)
local function goto_tag()
  local word = vim.fn.expand("<cWORD>")

  if word == "" then
    vim.notify("No word under cursor", vim.log.levels.WARN)
    return
  end

  -- Convert Ruby namespace syntax (Admin::UserService) to ctags format (Admin.UserService)
  -- ctags uses dot notation for nested classes/modules
  local tag_name = word:gsub("::", ".")

  -- Find all matching tags
  local matches = vim.fn.taglist("^" .. tag_name .. "$")

  if #matches == 0 then
    -- Fallback to class picker with search pre-filled
    telescope_tags_picker(tag_name)
    return
  end

  if #matches == 1 then
    -- Single match: jump directly to the tag
    vim.cmd("tag " .. vim.fn.escape(tag_name, "\\| "))
    return
  end

  -- Multiple matches: open telescope picker to choose
  open_tag_picker(tag_name, matches)
end

-- Global keymap for class picker
vim.keymap.set("n", "<leader>gc", telescope_tags_picker, { desc = "Search classes/components" })

-- FileType autocmd for gd mapping (ruby, tsx, jsx)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ruby", "typescriptreact", "javascriptreact" },
  callback = function()
    vim.keymap.set("n", "gd", goto_tag, { buffer = true, desc = "Go to class definition" })
  end,
})
