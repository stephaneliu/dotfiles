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

    vim.keymap.set("i", "<C-e>", replace_emoji, { desc = "Replace :emoji: with actual emoji" })
    vim.keymap.set("n", "<leader>e", replace_emoji, { desc = "Replace :emoji: with actual emoji" })
  end
}
