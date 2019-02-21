" javascript

let g:ale_linters = {
\   'javascript': ['eslint'],
\}

let b:ale_fixers = ['prettier_eslint', 'prettier-eslint', 'eslint', 'prettier']


let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_javascript_eslint_use_global = 1

set tabstop=4 "set tabs to 4 spaces
set shiftwidth=4 "indent width for autoindent
