lua << EOF
local Plug = vim.fn['plug#']

Plug('nvim-lua/plenary.nvim')
Plug('CopilotC-Nvim/CopilotChat.nvim', { ['branch'] = 'canary' })

-- require("CopilotChat").setup {
--   debug = true,
--   disable_extra_info = 'no'
-- }

-- return {
--   "CopilotC-Nvim/CopilotChat.nvim",
--   opts = {
--     disable_extra_info = 'no'
--   }
-- }
EOF
