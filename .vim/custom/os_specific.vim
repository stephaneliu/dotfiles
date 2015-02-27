let s:uname = system("echo -n \"$(uname)\"")

" Only on macs
if s:uname == "Darwin"
  " set clipboard=unnamed
  " Preserve indentation while pasting text from OS X clipboard
  noremap <leader> p :set paste<CR>:put *<CR>:set nopaste<CR>
else
  " set clipboard=unnamedplus     " Requires vim-7.3.74
  set clipboard=unnamed    "http://robots.thoughtbot.com/post/19398560514/how-to-copy-and-paste-with-tmux-on-mac-os-x
  set background=dark
  colorscheme solarized
endif
