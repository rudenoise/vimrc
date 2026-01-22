---@diagnostic disable: undefined-global

-- ============================================================================
-- LSP Configuration
-- ============================================================================

-- Suppress deprecation warnings from lspconfig
-- The warning is triggered when accessing lspconfig[lsp] via the metatable
-- We suppress all WARN level messages during server setup
local original_notify = vim.notify
local in_server_setup = false

vim.notify = function(msg, level, opts)
  if in_server_setup and level == vim.log.levels.WARN then
    return
  end
  return original_notify(msg, level, opts)
end

-- Load lspconfig (deprecation warnings suppressed during server setup)
local lspconfig = require('lspconfig')

-- ============================================================================
-- LSP Key Mappings
-- ============================================================================

local function on_attach(client, bufnr)
  _ = client -- Mark as used to avoid linter warning

  local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local buf_set_option = function(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap = true, silent = true }

  -- Enable completion
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Navigation
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- Workspace
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  -- Actions
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

  -- Diagnostics
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<leader>l', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
end

-- ============================================================================
-- Language-Specific Setup
-- ============================================================================

-- Terraform filetype detection
vim.cmd([[
  silent! autocmd! filetypedetect BufRead,BufNewFile *.tf
  autocmd BufRead,BufNewFile *.hcl set filetype=hcl
  autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl
  autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform
  autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json
  let g:terraform_fmt_on_save=1
  let g:terraform_align=1
]])

-- Scala/Metals setup
local metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach({})
  end,
  group = metals_group,
})

-- ============================================================================
-- LSP Server Configuration
-- ============================================================================

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = {
  'bashls',
  'clangd',
  'lua_ls',
  'ruff',
  'sourcekit',
  'terraformls',
  'ts_ls',
  'tflint',
  'yamlls',
  'zls',
}

-- Setup common servers
in_server_setup = true
for _, server_name in ipairs(servers) do
  lspconfig[server_name].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  })
end
in_server_setup = false

-- Pyright with Pipfile support
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  on_new_config = function(new_config, root_dir)
    local util = require("lspconfig").util
    local pipfile_path = util.path.join(root_dir, "Pipfile")
    if util.path.is_file(pipfile_path) then
      new_config.cmd = { "pipenv", "run", "pyright-langserver", "--stdio" }
    end
  end,
})

-- Restore original notify function
vim.notify = original_notify
