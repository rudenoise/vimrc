" html


set tabstop=2 "set tabs to 4 spaces
set shiftwidth=2 "indent width for autoindent

"http://api.html-tidy.org/tidy/quickref_5.4.0.html
let b:ale_html_tidy_executable = '/usr/bin/tidy'
let b:ale_html_tidy_options = '--doctype html5 --tidy-mark no --indent yes --indent-spaces 4 --wrap 0 --write-back yes --output-html yes --drop-empty-elements no'

let b:ale_linters = ['tidy']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace', 'tidy']

let b:ale_fix_on_save = 1
let b:ale_completion_enabled = 1
let b:ale_html_tidy_use_global = 1

