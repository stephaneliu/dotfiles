-- Manage sessions :SaveSession / OpenSession
return {
  'xolox/vim-session',
  enabled = true,
  dependencies = { 'xolox/vim-misc' },

  init = function()
    vim.g.session_directory = "/Users/" .. os.getenv("USER") .. "/.config/nvim/sessions"
    vim.g.session_autosave = 'no'
    vim.g.session_autoload = 'no'

    vim.api.nvim_create_user_command('SS', function()
      local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD 2>/dev/null'):gsub('\n', '')
      if branch == '' then
        print('Not in a git repository')
        return
      end
      local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':t'):gsub('^%.', '')
      local session_name = dir .. '-' .. branch
      vim.cmd('SaveSession ' .. session_name)
    end, {})
  end
}
