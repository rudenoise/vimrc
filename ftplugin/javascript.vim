" javascript


set tabstop=4 "set tabs to 4 spaces
set shiftwidth=4 "indent width for autoindent

let b:ale_linters = ['eslint']

let b:ale_fixers = ['prettier-eslint', 'eslint', 'prettier']

let b:ale_javascript_prettier_options = '--tab-width 4 --single-quote'

let b:ale_fix_on_save = 1
let b:ale_completion_enabled = 1
let b:ale_javascript_eslint_use_global = 1
