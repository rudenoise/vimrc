---@diagnostic disable: undefined-global

-- ============================================================================
-- Basic Settings
-- ============================================================================

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

-- ============================================================================
-- Filetype & Syntax
-- ============================================================================

vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

-- ============================================================================
-- Key Mappings
-- ============================================================================

vim.keymap.set('n', '<Leader>w', ':set spell wrap linebreak<CR>', { silent = true })

-- ============================================================================
-- File Browsing (netrw)
-- ============================================================================

vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 25

-- ============================================================================
-- Autocommands
-- ============================================================================

-- Overlength highlighting
vim.cmd([[
  augroup vimrc_autocmds
    autocmd BufEnter * highlight OverLength ctermbg=darkgrey
    autocmd BufEnter * match OverLength /\%80v.*/
  augroup END
]])

-- Text width for markdown and text files
vim.cmd([[
  augroup textwidth
    autocmd BufRead,BufNewFile *.md,*.txt setlocal textwidth=80
  augroup END
]])

-- ============================================================================
-- Python Provider
-- ============================================================================

vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = '/Users/joel.hughes/.pyenv/shims/python3'
vim.g.python_host_prog = '/Users/joel.hughes/.pyenv/shims/python3'

-- ============================================================================
-- Plugin Loading
-- ============================================================================

require('plugins')
require('lsp')
require('completion')

-- ============================================================================
-- Colorscheme
-- ============================================================================

vim.cmd('colorscheme tender')
