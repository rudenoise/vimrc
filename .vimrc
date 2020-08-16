set number
set shiftwidth=2 softtabstop=2
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

highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
match ExtraWhitespace /\s\+$/



set rtp+=/usr/local/opt/fzf

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()
