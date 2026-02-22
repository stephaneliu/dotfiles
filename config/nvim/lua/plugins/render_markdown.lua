return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  ft = { 'markdown' },
  opts = {
    preset = 'obsidian',
    anti_conceal = {
      enabled = true,
      above = 0,
      below = 0,
    },
    checkbox = {
      enabled = true,
      unchecked = {
        icon = '󰄱 ',
        highlight = 'RenderMarkdownUnchecked',
      },
      checked = {
        icon = '󰱒 ',
        highlight = 'RenderMarkdownChecked',
      },
    },
    bullet = {
      enabled = true,
    },
    heading = {
      enabled = true,
    },
    code = {
      enabled = true,
      style = 'full',
    },
    link = {
      enabled = true,
    },
  },
}
