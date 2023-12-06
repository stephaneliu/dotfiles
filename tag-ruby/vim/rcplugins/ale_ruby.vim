" Plug 'dense-analysis/ale'
" " Disable Language Server Protocol as it is being implemented by CoC
" let g:ale_disable_lsp = 1
"
" let g:ale_linters = {
"      \  'ruby': [
"      \    'standardrb',
"      \  ],
"      \ }
" let g:ale_fixers = {
"      \  '*': [
"      \    'remove_trailing_lines',
"      \    'trim_whitespace'
"      \  ],
"      \  'ruby': ['standardrb'],
"      \  'javascript': ['prettier']
"      \ }
" let g:ale_fix_on_save = 1
" " Only run linters named in ale_linters settings
" " https://github.com/dense-analysis/ale/blob/ed8104b6ab10f63c78e49b60d2468ae2656250e9/README.md#5i-how-do-i-disable-particular-linters
" let g:ale_linters_explicit = 1
"
" function! LinterStatus() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"
"   return l:counts.total == 0 ? '✨ 🙌 ✨' : printf(
"         \   '😞 %dW %dE',
"         \   all_non_errors,
"         \   all_errors
"         \)
" endfunction
"
" " set statusline=
" set statusline+=%m
" set statusline+=\ %f
" set statusline+=%=
" set statusline+=\ %{LinterStatus()}
