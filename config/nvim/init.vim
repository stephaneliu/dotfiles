set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

let mapleader=","

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

call plug#begin('~/.vim/bundle')
call s:SourceConfigFilesIn('rcplugins')
call plug#end()

filetype plugin indent on " required
syntax enable " Must be before configuring plugins which configures syntax highlighting color

call s:SourceConfigFilesIn('')

colorscheme NeoSolarized
