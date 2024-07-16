-- :TrimToggle topggle trim on save
-- :Trim trim right now!
return {
  'cappyzawa/trim.nvim',
  enabled = true,
  opts = {
    -- you can specify filetypes to ignore.
    -- ft_blocklist = {"markdown"},

    -- -- if you want to remove multiple blank lines
    -- patterns = {
    --   [[%s/\(\n\n\)\n\+/\1/]],   -- replace multiple blank lines with a single line
    -- },

    -- if you want to disable trim on write by default
    trim_on_write = true,

    -- highlight trailing spaces
    highlight = false,
  }
}
