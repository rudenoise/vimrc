" ocaml stuff:
" opc indent:
" ln -s ~/code/ocp-indent-vim ~/.vim/bundle/ocp-indent-vim
" merlin auto-complete:
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
let g:syntastic_ocaml_checkers = ['merlin']
map <Leader>e :MerlinErrorCheck<CR>
map <Leader>t :MerlinTypeOf<CR>

