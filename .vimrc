set number
set shiftwidth=2 softtabstop=2
set expandtab
set nocompatible
set nobackup
" set rnu
set backspace=indent,eol,start
filetype plugin on
filetype plugin indent on
syntax on
map <Leader>w :set spell wrap linebreak<CR>

augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgreen guibg=lightgreen
  autocmd BufEnter * match OverLength /\%72v.*/
augroup END



set rtp+=/usr/local/opt/fzf

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'psf/black', { 'branch': 'stable' }
Plug 'andviro/flake8-vim'

Plug 'dense-analysis/ale'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()
