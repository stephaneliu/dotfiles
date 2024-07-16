return {
  'godlygeek/tabular',
  enabled = true,
  keys = {
    { '<leader>a=', '<CMD>Tabularize /=<CR><ESC>', mode = {'v'} },
    { '<leader>ae', '<CMD>Tabularize /=<CR><ESC>', mode = {'v'} },
    { '<leader>a:', '<CMD>Tabularize /:<CR><ESC>', mode = {'v'} },
    { '<leader>a;', '<CMD>Tabularize /;<CR><ESC>', mode = {'v'} },
    { '<leader>a{', '<CMD>Tabularize /{<CR><ESC>', mode = {'v'} }, -- Match only the first { from text selected
    { '<leader>ac', '<CMD>Tabularize /{<CR><ESC>', mode = {'v'} },
    { '<leader>ah', '<CMD>Tabularize /=><CR><ESC>', mode = {'v'} },
    { '<leader>a#', '<CMD>Tabularize /#<CR><ESC>', mode = {'v'} },
    { '<leader>a-', '<CMD>Tabularize /-<CR><ESC>', mode = {'v'} },
    { '<leader>as', '<CMD>Tabularize /-><CR><ESC>', mode = {'v'} }, -- match stabby lambda
  }
}
