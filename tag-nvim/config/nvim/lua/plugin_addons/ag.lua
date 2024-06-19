return {
  'mileszs/ack.vim',
  keys = {
    { "\\", ":Ag! -Q --smart-case --ignore-dir app/frontend --ignore-dir spec/cassettes<Space>" },
    { "{", ':Ag! -Q  \b<C-R>=expand("<cword>"))\b' }
  }
}
