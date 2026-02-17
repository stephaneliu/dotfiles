local toggle_key = "<C-,>"

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    focus_after_send = true,
    terminal = {
      split_width_percentage = 0.40,
      auto_close = true, -- Close terminal when Claude session ends
      snacks_win_opts = {
        -- Default to right split
        position = "left",
        width = 0.40,
        -- Bottom split
        -- position = "bottom",
        -- height = 0.4,
        -- width = 1.0,
        -- border = "rounded",

        -- Float window
        -- position = "float",
        -- width = 120,  -- Fixed width in columns
        -- height = 30,  -- Fixed height in rows
        -- border = "double",
        -- backdrop = 90,
        bo = {
          scrollback = 10000,
        },
        wo = {
          -- Use Normal highlight to match NeoSolarized dark background (#002b36)
          winhighlight = "Normal:Normal,NormalFloat:Normal,FloatBorder:FloatBorder",
        },
        keys = {
          q = false, -- Disable 'q' closing window in scrollback mode
          claude_hide = { toggle_key, function(self) self:hide() end, mode = "t", desc = "Hide Claude terminal" },
          scrollback = { "<C-[>", function() vim.cmd("stopinsert") end, mode = "t", desc = "Enter scrollback mode" },
          nav_h = { "<C-h>", function() vim.cmd("KittyNavigateLeft") end, mode = "t", desc = "Navigate left" },
          nav_j = { "<C-j>", function() vim.cmd("KittyNavigateDown") end, mode = "t", desc = "Navigate down" },
          nav_k = { "<C-k>", function() vim.cmd("KittyNavigateUp") end, mode = "t", desc = "Navigate up" },
          nav_l = { "<C-l>", function() vim.cmd("KittyNavigateRight") end, mode = "t", desc = "Navigate right" },
          width_inc = {
            "<M-S-C-Right>",
            function()
              local win = vim.api.nvim_get_current_win()
              vim.api.nvim_win_set_width(win, vim.api.nvim_win_get_width(win) + 10)
            end,
            mode = "t",
            desc = "Increase width",
          },
          width_dec = {
            "<M-S-C-Left>",
            function()
              local win = vim.api.nvim_get_current_win()
              vim.api.nvim_win_set_width(win, vim.api.nvim_win_get_width(win) - 10)
            end,
            mode = "t",
            desc = "Decrease width",
          },
        },
      },
    },
  },
  keys = {
    { "<leader>c", nil, desc = "AI/Claude Code" },
    {
      "<leader>ct",
      function()
        local current_tab = vim.api.nvim_get_current_tabpage()

        -- Check if Claude is open in another tab
        for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
          if tab ~= current_tab then
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
              local buf = vim.api.nvim_win_get_buf(win)
              -- Only check terminal buffers
              if vim.bo[buf].buftype == "terminal" then
                local bufname = vim.api.nvim_buf_get_name(buf)
                local term_title = vim.b[buf].term_title or ""
                if term_title:match("claude") or bufname:match("claude") then
                  -- Claude is in another tab, toggle twice: close then open in current
                  vim.cmd("ClaudeCode")
                  vim.cmd("ClaudeCode")
                  return
                end
              end
            end
          end
        end

        -- Claude not in another tab, just toggle normally
        vim.schedule(function()
          vim.cmd("ClaudeCode")
        end)
      end,
      desc = "Toggle Claude",
    },
    { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude with picker" },
    { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue most recent Claude" },
    { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    { "<leader>cs", "V<cmd>ClaudeCodeSend<cr>", mode = "n", desc = "Send line to Claude" },
    {
      "<leader>cs",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add (send) file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    },
    -- Diff management
    { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}
