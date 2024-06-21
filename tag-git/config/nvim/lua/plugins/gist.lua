return {
  'mattn/gist-vim',
  init = function()
    vim.g.gist_open_browser_after_post = 1
    vim.g.gist_clip_command = "pbcopy"  -- Copy the URL after gisting
    vim.g.gist_post_private = 1         -- Post privately by default
  end
}
