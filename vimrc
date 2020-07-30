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
  " set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin('~/.vim/bundle')
  " Must rename file because Vundle complains when it is loaded later ins
  source ~/.vim/init_plugins " file to manage plugins
  " source `~/.vim/plugins/*`
  " For example, `~/.vim/plugins/ruby.vim` is symlinked to `tag-ruby/vim/plugins/ruby.vim`
  call s:SourceConfigFilesIn('plugins')
  call vundle#end()
endfunction

let mapleader=","  " maps leader from \" (double quote) to ,

call s:LoadPlugins()

" vundle loads all the file-type, syntax and color scheme files, so turn them
" on after loading plugins
filetype plugin indent on " required

call s:SourceConfigFilesIn('')
call s:SourceConfigFilesIn('functions')
call s:SourceConfigFilesIn('rcplugins')

syntax enable

" check off a todo item and time stamp it
map tc ^rx: <Esc>:r! date +" [\%I:\%M \%p]"<ENTER>kJA<Esc>$
" create a new todo item
map tn o_
