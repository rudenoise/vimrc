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

autocmd Filetype scheme setlocal sts=2 sw=2 noexpandtab
autocmd Filetype scm setlocal sts=2 sw=2 noexpandtab

" goLang stuff:
autocmd Filetype go setlocal ts=2 sts=2 sw=2 noexpandtab


" ocaml stuff:
" opc indent:
" ln -s ~/code/ocp-indent-vim ~/.vim/bundle/ocp-indent-vim
" merlin auto-complete:
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
let g:syntastic_ocaml_checkers = ['merlin']
map <Leader>e :MerlinErrorCheck<CR>
map <Leader>t :MerlinTypeOf<CR>

" Swift stuff

autocmd Filetype swift setlocal sts=2 sw=2

let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" assembly
autocmd Filetype asm setlocal ts=2 sts=2 sw=2 noexpandtab

