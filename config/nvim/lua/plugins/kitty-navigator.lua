return {
  "knubie/vim-kitty-navigator",
  build = "cp ./*.py ~/.config/kitty/",
  init = function()
    vim.cmd [[
      let g:kitty_navigator_enable_stack_layout = 1
    ]]
  end
}
