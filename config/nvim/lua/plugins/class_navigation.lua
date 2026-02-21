-- Class navigation via ctags for Ruby and React filetypes
-- Provides gd keymap for jump-to-class and <leader>gc for fuzzy class search

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

  -- TODO: Task 2.1.2 - Implement single-match jump logic using vim.fn.taglist()
  -- TODO: Task 2.1.3 - Implement multi-match telescope picker
  vim.notify("goto_tag: " .. tag_name .. " (jump logic pending)", vim.log.levels.DEBUG)
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
