-- Rust filetype settings

-- 4-space indentation (Rust standard)
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4

-- Set up LSP diagnostics for Rust files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
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
