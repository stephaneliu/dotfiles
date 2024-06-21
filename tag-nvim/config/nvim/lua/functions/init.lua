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

