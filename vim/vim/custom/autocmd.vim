if has("autocmd")
  " when we reload, tell vim to restore the cursor to the saved position
  augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
   \ if expand(":p:h") !=? $TEMP |
   \ if line("'\"") > 1 && line("'\"") <= line("$") |
   \ let JumpCursorOnEdit_foo = line("'\"") |
   \ let b:doopenfold = 1 |
   \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
   \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
   \ let b:doopenfold = 2 |
   \ endif |
   \ exe JumpCursorOnEdit_foo |
   \ endif |
   \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
   \ if exists("b:doopenfold") |
   \ exe "normal zv" |
   \ if(b:doopenfold > 1) |
   \ exe "+".1 |
   \ endif |
   \ unlet b:doopenfold |
   \ endif
  augroup END

  " Auto deletes git browse buffers when not active (fugitive)
  autocmd BufReadPost fugitive://* set bufhidden=delete

  " hide comments in ruby files 
  " Remove comment on end to auto fold on file load
  " see travisjeffery.com/b/2012/01/automaticallly-fold-comments-in-vim for
  autocmd FileType ruby,eruby set foldmethod=expr | set foldexpr=getline(v:lnum)=~'^\\s*#'

endif

