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
map <Leader>e :MerlinErrorCheck<CR>
map <Leader>t :MerlinTypeOf<CR>

au VimEnter * RainbowParenthesesToggle
au BufEnter * RainbowParenthesesLoadRound
au BufEnter * RainbowParenthesesLoadSquare
au BufEnter * RainbowParenthesesLoadBraces

autocmd Filetype scheme setlocal sts=2 sw=2 noexpandtab
autocmd Filetype scm setlocal sts=2 sw=2 noexpandtab

" goLang stuff:
autocmd Filetype go setlocal ts=2 sts=2 sw=2 noexpandtab

autocmd Filetype swift setlocal sts=4 sw=4

execute pathogen#infect()

" ocaml stuff:
" opc indent:
" ln -s ~/code/ocp-indent-vim ~/.vim/bundle/ocp-indent-vim
" merlin auto-complete:
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
let g:syntastic_ocaml_checkers = ['merlin']

let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
