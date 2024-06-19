-- Manage sessions :SaveSession / OpenSession
return {
  'xolox/vim-session',
  dependencies = { 'xolox/vim-misc' },
  init = function()
    vim.g.session_directory = "~/.config/nvim/sessions"
    vim.g.session_autosave = 'no'
    vim.g.session_autoload = 'no'
  end
}
