-- Python filetype settings
vim.opt.encoding = 'utf-8'

-- Set up autocommands for Python files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.textwidth = 79
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
    vim.opt_local.fileformat = 'unix'
  end
})

-- Python provider settings
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = '/Users/rudenoise/.asdf/shims/python'
vim.g.python_host_prog = '/Users/rudenoise/.asdf/shims/python' 