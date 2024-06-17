vim.api.nvim_exec("iabbrev fsl # frozen_string_literal: true", false)

-- pry
vim.api.nvim_exec("iabbrev bpry binding.pry", false)
vim.api.nvim_exec("iabbrev bpid binding.pry if Rails.env.development?", false)
vim.api.nvim_exec("iabbrev bpit binding.pry if Rails.env.test?", false)
vim.api.nvim_exec("iabbrev brp binding.remote_pry", false)
vim.api.nvim_exec("iabbrev brpid binding.remote_pry if Rails.env.development?", false)
vim.api.nvim_exec("iabbrev brpit binding.remote.pry if Rails.env.test?", false)

-- byebug
vim.api.nvim_exec("iabbrev bb byebug", false)

-- RSpec
vim.api.nvim_exec("iabbrev af :aggregate_failures", false)
