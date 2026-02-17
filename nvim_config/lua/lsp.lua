-- LSP configuration for Neovim 0.11+
-- Uses vim.lsp.config / vim.lsp.enable instead of the deprecated lspconfig framework.

-- Shared capabilities (nvim-cmp integration)
vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  root_markers = { '.git' },
})

-- Pyright: use pipenv when a Pipfile is present
vim.lsp.config('pyright', {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local dir = vim.fs.dirname(fname)
    local root = vim.fs.root(bufnr, { 'pyrightconfig.json', 'pyproject.toml', 'setup.py', '.git' })
    if root then
      on_dir(root)
    elseif dir then
      on_dir(dir)
    end
  end,
  on_init = function(client)
    local root = client.config.root_dir
    if root and vim.uv.fs_stat(root .. '/Pipfile') then
      client.config.cmd = { 'pipenv', 'run', 'pyright-langserver', '--stdio' }
    end
  end,
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      },
      cargo = {
        allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

-- Enable all LSP servers
-- These must be installed on the system (see scripts/setup.sh)
vim.lsp.enable({
  'bashls',
  'clangd',
  'lua_ls',
  'pyright',
  'ruff',
  'rust_analyzer',
  'sourcekit',
  'terraformls',
  'tflint',
  'ts_ls',
  'yamlls',
  'zls',
})

-- Keymaps on attach
-- Neovim 0.11 provides these defaults: K (hover), grn (rename), gra (code_action),
-- grr (references), gri (implementation), grt (type_definition), gO (document_symbol),
-- CTRL-S (signature_help), omnifunc, tagfunc (CTRL-] for go-to-definition).
-- We only add keymaps that aren't built-in defaults.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.format, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    -- Diagnostics
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setqflist, opts)
    vim.keymap.set('n', '<leader>l', vim.diagnostic.setqflist, opts)
  end,
})

-- Terraform filetype detection
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])
vim.cmd([[let g:terraform_fmt_on_save=1]])
vim.cmd([[let g:terraform_align=1]])

-- Scala (nvim-metals)
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach({})
  end,
  group = nvim_metals_group,
})
