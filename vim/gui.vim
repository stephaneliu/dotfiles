set guifont=Droid\ Sans\ Mono

if has('gui_running')
  set guioptions-=T                 " hide the toolbar - who uses it anyways?
  set macligatures
  " set guifont=Fira\ Code\ Retina:h11
  set guifont=JetBrainsMono\ Nerd\ Font:h12
endif

set statusline=1
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P " show git info

" set statusline=%t\ %y\ format:\ %{&ff};\ [%c,%l]
