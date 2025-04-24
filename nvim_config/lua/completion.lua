local cmp = require'cmp'

-- Set completeopt
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

-- Helper functions for completion
local function select_next(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
  end
end

local function select_prev(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
  end
end

-- Setup nvim-cmp
cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body)
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
    { name = 'vsnip' },
    { name = 'buffer' },
  }
}) 