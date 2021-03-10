" Disable Language Server Protocol as it is being implemented by CoC
let g:ale_disable_lsp = 1

let g:ale_linters = {
      \ 'ruby': [
      \   'rubocop',
      \   'prettier', '--check',
      \   'brakeman'
      \ ],
      \ 'haml': ['haml-lint'],
      \}
let g:ale_fixers = {
      \ '*': [
      \   'remove_trailing_lines',
      \   'trim_whitespace'
      \ ],
      \ 'ruby': [
      \   'prettier'
      \ ],
      \}
let g:ale_fix_on_save = 1

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ 🙌 ✨' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}
