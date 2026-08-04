__map = function(key, val, no_remap)
  -- bare 'map'
  custom_map('', key, val, no_remap)
end

c_map = function(key, val, no_remap)
  custom_map('c', key, val, no_remap)
end

i_map = function(key, val, no_remap)
  custom_map('i', key, val, no_remap)
end

n_map = function(key, val, no_remap)
  custom_map('n', key, val, no_remap)
end

v_map = function(key, val, no_remap)
  custom_map('v', key, val, no_remap)
end

nv_map = function(key, val, no_remap)
  custom_map({'n', 'v'}, key, val, no_remap)
end

custom_map = function(map_type, key, val, no_remap)
  no_remap = no_remap or true
  vim.keymap.set(map_type, key, val, {noremap = no_remap})
end

-- `<C-w>=` ignores snacks.nvim splits (claudecode) because snacks sets
-- winfixwidth=true on left/right splits. Clear it across the tab, equalize,
-- then restore.
equalize_windows = function()
  local fixed = {}
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    fixed[win] = vim.wo[win].winfixwidth
    vim.wo[win].winfixwidth = false
  end
  vim.cmd("wincmd =")
  for win, val in pairs(fixed) do
    if vim.api.nvim_win_is_valid(win) then
      vim.wo[win].winfixwidth = val
    end
  end
end

