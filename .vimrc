set number
set shiftwidth=2 softtabstop=2
set expandtab
set nocompatible
set nobackup
set rnu
set backspace=indent,eol,start
filetype plugin on
filetype plugin indent on
syntax on
map <Leader>w :set spell wrap linebreak<CR>

" settings for file browsing with Vexplore, Sexplore, Lexplore etxc...
" https://neovim.io/doc/user/pi_netrw.html#g%3Anetrw_browse_split
" https://neovim.io/doc/user/pi_netrw.html#netrw-quickcom
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25

augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey
  autocmd BufEnter * match OverLength /\%80v.*/
augroup END

" wrap text at 80 chars in md and txt
au BufRead,BufNewFile *.md setlocal textwidth=80  
au BufRead,BufNewFile *.txt setlocal textwidth=80

set rtp+=/usr/local/opt/fzf

call plug#begin('~/.vim/plugged')

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

" For vsnip user:
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'tpope/vim-sensible'

" Search/Navigate:
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'jremmen/vim-ripgrep'

" Python bits:
Plug 'karloskar/poetry-nvim'
" Plug 'psf/black'
" Plug 'andviro/flake8-vim'
" Plug 'fisadev/vim-isort'

" LSP bits
Plug 'neovim/nvim-lspconfig'

Plug 'ziglang/zig.vim'

" Scala bits
Plug 'nvim-lua/plenary.nvim'
Plug 'scalameta/nvim-metals'

" Go bits
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" terraform bits
Plug 'hashivim/vim-terraform'



" Colour Schemes
Plug 'jacoborus/tender.vim'
Plug 'rhysd/vim-color-spring-night'
Plug 'glepnir/oceanic-material'

call plug#end()

colorscheme tender
set cursorline cursorcolumn

set completeopt=menu,menuone,noselect

let g:loaded_python_provider = 0
let g:python3_host_prog = '/Users/rudenoise/.asdf/shims/python'
let g:python_host_prog = '/Users/rudenoise/.asdf/shims/python'

lua << EOF


-- setup terraform stuff
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])
vim.cmd([[let g:terraform_fmt_on_save=1]])
vim.cmd([[let g:terraform_align=1]])


-- scala stuff
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach({})
  end,
  group = nvim_metals_group,
})

-- lsp stuff
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

end

local cmp = require'cmp'

  function select_next(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    else
      fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    end
  end
  function select_prev(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    else
      fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    end
  end


  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body)

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        -- vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(select_next, { "i", "s" }),
      ["<Down>"] = cmp.mapping(select_next, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(select_prev, { "i", "s" }),
      ["<Up>"] = cmp.mapping(select_prev, { "i", "s" }),
    },
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      { name = 'vsnip' },

      -- For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

      { name = 'buffer' },
    }
  })

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- see lsp configs here: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls



local servers = {
  'bashls',
  'clangd',
  'lua_ls',
--  'pyright',
  'ruff',
  'sourcekit',
  'terraformls',
  'ts_ls',
  'tflint',
  'yamlls',
  'zls'
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

nvim_lsp['pyright'].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  on_new_config = function(new_config, root_dir)
    local pipfile_exists = require("lspconfig").util.search_ancestors(root_dir, function(path)
      local pipfile = require("lspconfig").util.path.join(path, "Pipfile")
      if require("lspconfig").util.path.is_file(pipfile) then
          return true
      else
        return false
      end
    end)

    if pipfile_exists then
      new_config.cmd = { "pipenv", "run", "pyright-langserver", "--stdio" }
    end
  end,
})
EOF

