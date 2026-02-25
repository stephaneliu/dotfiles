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
    local function set_neogit_highlights()
      -- Get background from Normal or NormalFloat (handles transparent themes)
      local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
      local normal_float = vim.api.nvim_get_hl(0, { name = 'NormalFloat' })
      local bg = normal.bg or normal_float.bg
      local fg = normal.fg or normal_float.fg

      if bg then
        vim.api.nvim_set_hl(0, 'NeogitNormal', { bg = bg, fg = fg })
        vim.api.nvim_set_hl(0, 'NeogitNormalFloat', { bg = bg, fg = fg })
      else
        vim.api.nvim_set_hl(0, 'NeogitNormal', { link = 'NormalFloat' })
        vim.api.nvim_set_hl(0, 'NeogitNormalFloat', { link = 'NormalFloat' })
      end
      vim.api.nvim_set_hl(0, 'NeogitFloatBorder', { link = 'FloatBorder' })
      vim.api.nvim_set_hl(0, 'NeogitWinSeparator', { link = 'WinSeparator' })
    end

    require('neogit').setup({
      verbose = true,
      kind = 'split',
      auto_close_console = true,
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

    -- Set highlights initially and on colorscheme change
    set_neogit_highlights()
    local augroup = vim.api.nvim_create_augroup('NeogitColors', { clear = true })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = augroup,
      callback = set_neogit_highlights,
    })

    -- Fix terminal buffer background for git console
    vim.api.nvim_create_autocmd('BufWinEnter', {
      group = augroup,
      callback = function()
        if vim.bo.filetype == 'NeogitConsole' then
          vim.schedule(function()
            vim.wo.winhighlight = 'Normal:NeogitNormal,EndOfBuffer:NeogitNormal'
          end)
        end
      end,
    })
  end,
}
