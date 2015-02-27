runtime! macros/matchit.vim                           " Find matching ( ), [ ], { } and def/end
let g:notes_suffix = '.txt'                           " Easy notes config
let g:notes_directories= ['~/vim_notes']
let journal_directory = '~/vim-notes'       " Journal settings
let NERDTreeQuitOnOpen = 1                            " NERDTree config
let NERDTreeShowHidden = 1
let g:indent_guides_auto_colors = 1

" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black ctermbg=0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=black ctermbg=6
filetype plugin on                                    " enable ctag plugin
set tags+=gems.tags                                   " add gems.tags (generated by guard-ctags-bundler) to list of inspected ctags
 
" thoughtbot rspec plugin
" let g:rspec_command = "Dispatch spring rspec {spec}"
" let g:rspec_command = "Dispatch rspec {spec}"

" let g:rspec_command = "Dispatch bundle exec rspec {spec}"
let g:rspec_command = "!bundle exec rspec {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
" map <Leader>t :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>

vmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>ae :Tabularize /=<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a{ :Tabularize /{<CR>
vmap <Leader>ah :Tabularize /=><CR>
vmap <Leader>a# :Tabularize /#<CR>
vmap <Leader>a- :Tabularize /-><CR>

" The Silver Searcher
if executable('ag')
  "Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-dir\ tags
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore-dir gems.tags --ignore-dir tmp -g ""'
  " ag is fast enought that CtrlP doesn't need to cache
  let g:ctrl_p_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! --ignore gems.tags --ignore log --ignore tags --ignore tmp <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" fugitive extensions
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \  nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

" Auto fold by indent when file is opened
" augroup vimrc
"   au BufReadPre * setlocal foldmethod=indent
"   au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" augroup END


" gitgutter
let g:gitgutter_highlight_lines = 1
