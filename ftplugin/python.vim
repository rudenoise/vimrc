set encoding=utf-8

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

let g:loaded_python_provider = 0
let g:python3_host_prog = '/Users/rudenoise/.asdf/shims/python'
let g:python_host_prog = '/Users/rudenoise/.asdf/shims/python'
