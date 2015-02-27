" Tell vim to remember certain things when we exit
set viminfo='10,\"100,:20,%,n~/.viminfo
"            |    |    |  | |
"            marks will be remembered for up to 10 previously edited files
"                 |    |  | |
"                 save up to 100 lines for each register
"                      |  | |
"                      20 lines of command-line history will be remembered
"                         | |
"                         saves and restores the buffer list
"                           |
"                           where to save the viminfo files


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
