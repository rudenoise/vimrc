" javascript


set tabstop=2 "set tabs to 2 spaces
set shiftwidth=2 "indent width for autoindent

let b:ale_linters = ['eslint']
let b:ale_fixers = ['prettier-eslint', 'eslint', 'prettier']

let b:ale_javascript_prettier_options = '--tab-width 2 --single-quote'

let b:ale_fix_on_save = 1
let b:ale_lint_on_enter = 1
let b:ale_lint_on_save = 1
let b:ale_completion_enabled = 1
" let b:ale_javascript_eslint_use_global = 1
