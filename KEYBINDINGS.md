# Neovim Keybindings

## General (`init.lua`)

| Mode | Keys | Action |
|------|------|--------|
| Normal | `<Leader>w` | Enable spell check + word wrap |

## LSP (`lua/lsp.lua`)

| Mode | Keys | Action |
|------|------|--------|
| Normal | `gD` | Go to declaration |
| Normal | `<Space>f` | Format buffer |
| Normal | `<Space>wa` | Add workspace folder |
| Normal | `<Space>wr` | Remove workspace folder |
| Normal | `<Space>wl` | List workspace folders |
| Normal | `<Space>e` | Show diagnostics (float) |
| Normal | `<Leader>d` | Show diagnostics (float) |
| Normal | `[d` | Previous diagnostic |
| Normal | `]d` | Next diagnostic |
| Normal | `<Space>q` | Diagnostics to quickfix list |
| Normal | `<Leader>l` | Diagnostics to quickfix list |

## Neovim 0.11 Built-in LSP Defaults

| Mode | Keys | Action |
|------|------|--------|
| Normal | `K` | Hover info |
| Normal | `grn` | Rename symbol |
| Normal | `gra` | Code action |
| Normal | `grr` | References |
| Normal | `gri` | Implementation |
| Normal | `grt` | Type definition |
| Normal | `gO` | Document symbols |
| Normal | `<C-]>` | Go to definition |
| Insert | `<C-S>` | Signature help |

## Completion (`lua/completion.lua`)

| Mode | Keys | Action |
|------|------|--------|
| Insert | `<C-d>` | Scroll docs up |
| Insert | `<C-f>` | Scroll docs down |
| Insert | `<C-Space>` | Trigger completion |
| Insert | `<C-e>` | Close completion menu |
| Insert | `<CR>` | Confirm selection |
| Insert | `<Tab>` / `<Down>` | Next completion item |
| Insert | `<S-Tab>` / `<Up>` | Previous completion item |
