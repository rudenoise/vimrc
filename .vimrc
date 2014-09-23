set number
set shiftwidth=4 softtabstop=4
set expandtab
set nocompatible
set nobackup
set rnu
set backspace=indent,eol,start 
colorscheme zellner
set guifont=Monospace\ 14
filetype plugin indent on
syntax on
map <Leader>w :set spell wrap linebreak<CR>

au VimEnter * RainbowParenthesesToggle
au BufEnter * RainbowParenthesesLoadRound
au BufEnter * RainbowParenthesesLoadSquare
au BufEnter * RainbowParenthesesLoadBraces

autocmd Filetype schmem setlocal ts=2 sts=2 sw=2 noexpandtab

" goLang stuff:
"filetype off
"filetype plugin indent off
"set runtimepath+=$GOROOT/misc/vim
"filetype plugin indent on
"autocmd Filetype go setlocal ts=2 sts=2 sw=2 noexpandtab
