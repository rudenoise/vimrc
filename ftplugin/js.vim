" javascript

let g:ale_fix_on_save = 1

let g:ale_javascript_eslint_use_global = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

let g:ale_fixers = {
\   'javascript': ['prettier_eslint'],
\}
set tabstop=4 "set tabs to 4 spaces
set shiftwidth=4 "indent width for autoindent
