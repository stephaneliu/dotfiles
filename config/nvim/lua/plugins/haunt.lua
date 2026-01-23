return {
  "TheNoeTrevino/haunt.nvim",
  enabled = true,
  dependencies = { "folke/snacks.nvim" },
  event = "BufReadPost",
  opts = {
    data_dir = vim.fn.stdpath("data") .. "/haunt",
    virt_text_pos = "right_align",
  },
  keys = {
    {
      "<leader>hta",
      function()
        local haunt = require("haunt.api")
        local file = vim.fn.expand("%:p")
        local line = vim.fn.line(".")
        local default_text = ""
        for _, bm in ipairs(haunt.get_bookmarks()) do
          if bm.file == file and bm.line == line then
            default_text = (bm.note or ""):gsub("\n", " ")
            break
          end
        end
        vim.ui.input({ prompt = "Annotation: ", default = default_text }, function(text)
          if text and text ~= "" then
            haunt.annotate(text)
          end
        end)
      end,
      desc = "Add/edit annotation on current line"
    },
    {
      "<leader>htd",
      function()
        require("haunt.api").delete()
      end,
      desc = "Delete annotation on current line"
    },
    {
      "<leader>htn",
      function()
        require("haunt.api").next()
      end,
      desc = "Go to next annotation"
    },
    {
      "<leader>htp",
      function()
        require("haunt.api").prev()
      end,
      desc = "Go to previous annotation"
    },
    {
      "<leader>htt",
      function()
        require("haunt.api").toggle_annotation()
      end,
      desc = "Toggle annotation visibility"
    },
    {
      "<leader>hts",
      function()
        require("haunt.picker").show()
      end,
      desc = "Search annotations"
    },
    {
      "<leader>htC",
      function()
        require("haunt.api").clear()
      end,
      desc = "Clear all annotations in current file"
    },
  },
}
