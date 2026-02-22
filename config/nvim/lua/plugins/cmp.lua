return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },
  config = function()
    local cmp = require('cmp')
    local timer = nil

    cmp.setup({
      completion = {
        autocomplete = false, -- Disable auto-popup, we trigger manually after delay
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      }),
    })

    -- Trigger completion after 2 seconds of no typing
    vim.api.nvim_create_autocmd('TextChangedI', {
      callback = function()
        if timer then
          timer:stop()
        end
        timer = vim.defer_fn(function()
          if vim.fn.mode() == 'i' then
            cmp.complete()
          end
        end, 1000)
      end,
    })

    vim.api.nvim_create_autocmd('InsertLeave', {
      callback = function()
        if timer then
          timer:stop()
          timer = nil
        end
      end,
    })
  end,
}
