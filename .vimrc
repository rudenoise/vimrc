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

highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
match ExtraWhitespace /\s\+$/


execute pathogen#infect()

au VimEnter * RainbowParenthesesToggle
au BufEnter * RainbowParenthesesLoadRound
au BufEnter * RainbowParenthesesLoadSquare
au BufEnter * RainbowParenthesesLoadBraces

