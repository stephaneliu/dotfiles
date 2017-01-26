" Stolen wholesale from christoomey, whose dotfiles you really should check out:
" https://github.com/christoomey/dotfiles
function! s:SourceConfigFilesIn(directory)
  let directory_splat = '~/.vim/' . a:directory . '/*.vim'
  for config_file in split(glob(directory_splat), '\n')
    if filereadable(config_file)
      execute 'source' config_file
    endif
  endfor
endfunction

function! s:LoadPlugins()
  call plug#begin('~/.vim/bundle')
  call vundle#begin()
  source ~/.vim/plugin.vim
  " source `~/.vim/plugins/*`
  " For example, `~/.vim/plugins/haskell.vim` is symlinked to `tag-haskell/vim/plugins/haskell.vim`
  call s:SourceConfigFilesIn('plugins')
  call vundle#end()
endfunction

let mapleader=","  " maps leader from \" (double quote) to ,

call s:LoadPlugins()
call s:SourceConfigFilesIn('')
" call s:SourceConfigFilesIn('')

" vundle loads all the filetype, syntax and coloscheme files, so turn them
" on after loading plugins
filetype plugin indent on " required
syntax enable
