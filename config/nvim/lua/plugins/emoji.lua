-- Replace :emoji_name: with actual emoji
return {
  dir = "~/.config/nvim/lua/plugins",
  name = "emoji",
  lazy = false,

  config = function()
    local emoji_cache = {}

    local function load_emojis()
      if next(emoji_cache) then return emoji_cache end

      local cache_file = "/tmp/emoji_cache.txt"
      local file = io.open(cache_file, "r")
      if not file then return {} end

      for line in file:lines() do
        local emoji, name = line:match("^(%S+)%s+:([^:]+):")
        if emoji and name then
          emoji_cache[name] = emoji
        end
      end
      file:close()
      return emoji_cache
    end

    local function replace_emoji()
      local line = vim.api.nvim_get_current_line()
      local emojis = load_emojis()
      local new_line = line:gsub(":([%w_]+):", function(name)
        return emojis[name] or (":" .. name .. ":")
      end)
      if new_line ~= line then
        vim.api.nvim_set_current_line(new_line)
      end
    end

    local function search_emoji()
      local emojis = load_emojis()
      local line = vim.api.nvim_get_current_line()
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local before_cursor = line:sub(1, col)

      -- Find :search_term pattern before cursor
      local search_start, search_term = before_cursor:match(".*():([%w_]+)$")
      if not search_start then return end

      -- Find matching emojis
      local matches = {}
      for name, emoji in pairs(emojis) do
        if name:lower():find(search_term:lower(), 1, true) then
          table.insert(matches, { name = name, emoji = emoji })
        end
      end

      if #matches == 0 then
        vim.notify("No emoji found matching '" .. search_term .. "'", vim.log.levels.WARN)
        return
      end

      -- Sort by name length (shorter = better match), then alphabetically
      table.sort(matches, function(a, b)
        if #a.name ~= #b.name then return #a.name < #b.name end
        return a.name < b.name
      end)

      -- Use vim.ui.select for picking
      vim.ui.select(matches, {
        prompt = "Select emoji:",
        format_item = function(item)
          return item.emoji .. "  :" .. item.name .. ":"
        end,
      }, function(choice)
        if choice then
          -- Replace ::term with the emoji
          local new_line = line:sub(1, search_start - 1) .. choice.emoji .. line:sub(col + 1)
          vim.api.nvim_set_current_line(new_line)
          vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], search_start - 1 + #choice.emoji })
        end
      end)
    end

    vim.keymap.set("i", "<C-e>", replace_emoji, { desc = "Replace :emoji: with actual emoji" })
    vim.keymap.set("n", "<leader>e", replace_emoji, { desc = "Replace :emoji: with actual emoji" })
    vim.keymap.set("i", "<C-x><C-e>", search_emoji, { desc = "Search emoji after : trigger with c-x c-e" })
  end
}
