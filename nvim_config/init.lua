-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.backspace = 'indent,eol,start'
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- Enable filetype detection and plugins
vim.cmd('filetype plugin on')
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

-- Set up spell checking
vim.keymap.set('n', '<Leader>w', ':set spell wrap linebreak<CR>', { silent = true })

-- File browsing settings
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 25

-- Overlength highlighting
vim.cmd([[
  augroup vimrc_autocmds
    autocmd BufEnter * highlight OverLength ctermbg=darkgrey
    autocmd BufEnter * match OverLength /\%80v.*/
  augroup END
]])

-- Text width settings for markdown and text files
vim.cmd([[
  au BufRead,BufNewFile *.md setlocal textwidth=80
  au BufRead,BufNewFile *.txt setlocal textwidth=80
]])

-- Set up Python providers
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = '/Users/rudenoise/.asdf/shims/python'
vim.g.python_host_prog = '/Users/rudenoise/.asdf/shims/python'

-- Load plugins using packer.nvim
require('plugins')

-- Load LSP configuration
require('lsp')

-- Load completion configuration
require('completion')

-- Set colorscheme
vim.cmd('colorscheme tender')
