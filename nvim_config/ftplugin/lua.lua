---@diagnostic disable: undefined-global
-- Lua filetype settings and LSP configuration

-- Basic Lua settings
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2

-- Set up LSP diagnostics for Lua files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.diagnostic.config({
      virtual_text = {
        prefix = '●',
        spacing = 4,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = 'E',
          [vim.diagnostic.severity.WARN] = 'W',
          [vim.diagnostic.severity.INFO] = 'I',
          [vim.diagnostic.severity.HINT] = 'H',
        },
      },
      underline = true,
      update_in_insert = false,
    })
  end
})

-- Set up omnifunc for Lua files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
  end
}) 
