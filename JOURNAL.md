# Journal

## 2026-02-16 — Setup script idempotency and lspconfig deprecation

**Working on**: Making the nvim dotfiles repo self-contained and current with Neovim 0.11.
**State**: done

### What happened
User hit a missing `bash-language-server` after environment changes. Installed it, then rewrote `scripts/setup.sh` to be idempotent — every dependency is checked before install, the script can run repeatedly with no side effects. Also migrated `lsp.lua` from the deprecated `require('lspconfig')` framework to the native `vim.lsp.config` / `vim.lsp.enable` API introduced in Neovim 0.11.

### What I learned
- The old `lspconfig` setup pattern (`require('lspconfig').server.setup{}`) is deprecated in nvim-lspconfig v3. The plugin still provides server definitions but Neovim 0.11 loads them automatically — you just call `vim.lsp.config()` and `vim.lsp.enable()`.
- Neovim 0.11 ships a lot of LSP keymaps by default: K (hover), grn (rename), gra (code action), grr (references), gri (implementation), grt (type definition), gO (document symbol), CTRL-S (signature help), CTRL-] (go-to-definition via tagfunc). Most hand-rolled `on_attach` keymaps are now redundant.
- The `neovim` npm package doesn't provide a CLI binary, so `command -v` can't check for it — need `npm list -g` instead.
- User uses `mise` (not asdf) for runtime management now. The old asdf Python setup was stale.

### What's next
- The `packer_compiled.lua` diff is just a packer sync artifact, not a real change.
- Consider whether packer itself should be replaced (lazy.nvim is the successor).
- `python3_host_prog` in init.lua still points to `.asdf/shims/python` — should be updated to mise or removed.
