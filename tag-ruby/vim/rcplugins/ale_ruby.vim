let g:ale_linters = {
      \ 'ruby': ['prettier', '--check'],
      \ 'haml': ['haml-lint'],
      \}
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'ruby': ['prettier'],
      \}
let g:ale_fix_on_save = 1
