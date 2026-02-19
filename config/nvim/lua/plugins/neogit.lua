return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { '<leader>gs', '<CMD>Neogit<CR>', desc = 'Neogit' },
    { '<leader>gS', '<CMD>Neogit kind=tab<CR>', desc = 'Neogit (tab)' },
    { '<leader>gd', '<CMD>DiffviewOpen<CR>', desc = 'Diffview' },
    { '<leader>gh', '<CMD>DiffviewFileHistory %<CR>', desc = 'File history' },
  },
  config = function()
    require('neogit').setup({
      verbose = true,
      kind = 'split',
      integrations = {
        diffview = true,
        telescope = true,
      },
      mappings = {
        status = {
          ['gp'] = function()
            vim.cmd('!gh pr create --web')
          end,
          ['gS'] = function()
            require('neogit').open({ kind = 'tab' })
          end,
        },
      },
    })
  end,
}