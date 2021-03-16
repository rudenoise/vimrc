set encoding=utf-8

au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

augroup vimrc_autocmds
  "autocmd BufWritePre *.py execute ':Black'
  "autocmd InsertLeave *.py execute ':PyFlake'
augroup END
let PyFlakeOnWrite = 1
let PyFlakeCWindow = 6 
let PyFlakeSignStart = 1
let b:PyFlakeMaxLineLength = 88
let b:flake8_max_line_length = 88


let b:ale_linters = ['flake8']
let b:ale_fixers = ['black']
"let b:ale_python_auto_pipenv = 1
"let b:ale_python_flake8_auto_pipenv = 1
let b:ale_python_flake8_change_directory = 'project'
let b:ale_python_flake8_executable = 'flake8'
let b:ale_python_flake8_options = ''
let b:ale_python_flake8_use_global = 1
