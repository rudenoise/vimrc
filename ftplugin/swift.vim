" Swift stuff

autocmd Filetype swift setlocal sts=2 sw=2 noexpandtab

let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

