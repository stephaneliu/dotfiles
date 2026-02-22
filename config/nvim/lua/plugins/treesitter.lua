return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  main = 'nvim-treesitter',
  opts = {
    ensure_installed = {
      'markdown',
      'markdown_inline',
    },
    highlight = {
      enable = true,
    },
  },
}
