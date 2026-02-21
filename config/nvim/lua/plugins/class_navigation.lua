-- Class navigation via ctags for Ruby and React filetypes
-- Provides gd keymap for jump-to-class and <leader>gc for fuzzy class search

-- Open telescope picker filtered to specific tag name
-- Shows file path, line number, and preview pane with definition context
local function open_tag_picker(tag_name)
  local builtin = require("telescope.builtin")
  builtin.tags({
    default_text = tag_name,
    prompt_title = "Tag: " .. tag_name,
    show_line = true,
  })
end

-- Extract word under cursor and prepare it for tag lookup
-- Handles Ruby namespace syntax: Admin::UserService -> Admin.UserService (ctags format)
local function goto_tag()
  local word = vim.fn.expand("<cword>")

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
    vim.notify("Tag not found: " .. tag_name, vim.log.levels.WARN)
    return
  end

  if #matches == 1 then
    -- Single match: jump directly to the tag
    vim.cmd("tag " .. tag_name)
    return
  end

  -- Multiple matches: open telescope picker to choose
  open_tag_picker(tag_name)
end

return {
  "class-navigation",
  virtual = true,
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    -- Expose goto_tag for keymap binding (task 2.2.1)
    _G.class_navigation_goto_tag = goto_tag
  end,
}
