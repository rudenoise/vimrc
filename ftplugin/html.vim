" html


set tabstop=2 "set tabs to 4 spaces
set shiftwidth=2 "indent width for autoindent

"http://api.html-tidy.org/tidy/quickref_5.4.0.html
let b:ale_html_tidy_executable = '/usr/local/bin/tidy'
let b:ale_html_tidy_options = '-doctype html5 -qicbn'

let b:ale_linters = ['htmlhint']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace', 'tidy']

"let b:ale_html_stylelint_options = '--fix'

let b:ale_fix_on_save = 1
let b:ale_completion_enabled = 1
let b:ale_html_tidy_use_global = 1

