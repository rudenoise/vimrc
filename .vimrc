set number
set shiftwidth=4 softtabstop=4
set expandtab
set nocompatible
set nobackup
set rnu
set backspace=indent,eol,start
colorscheme zellner
set guifont=Monospace\ 14
filetype plugin on
filetype plugin indent on
syntax on
map <Leader>w :set spell wrap linebreak<CR>
map <Leader>a :let b:ale_fix_on_save = 0<CR>

highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
match ExtraWhitespace /\s\+$/


execute pathogen#infect()

set rtp+=/usr/local/opt/fzf

au VimEnter * RainbowParenthesesToggle
au BufEnter * RainbowParenthesesLoadRound
au BufEnter * RainbowParenthesesLoadSquare
au BufEnter * RainbowParenthesesLoadBraces

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
