return {
  "stevearc/conform.nvim",
  enabled = false,
  opts = function()
    local opts = {
      formatters_by_ft = {
        ruby = { "standardrb" },
      },
    }
    return opts
  end,
}
