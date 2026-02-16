# 0001 — Idempotent setup and LSP modernization

**Date**: 2026-02-16

## Starting Point

The nvim dotfiles repo had a `scripts/setup.sh` that worked but wasn't idempotent — npm installs ran unconditionally every time, several LSP servers configured in `lsp.lua` weren't installed by the script at all, and the Python section assumed asdf when the system had moved to mise. Meanwhile, Neovim had been updated to 0.11, and the `require('lspconfig')` pattern was throwing deprecation warnings.

The trigger: `bash-language-server` wasn't installed after environment changes, surfacing the gap between what `lsp.lua` expected and what `setup.sh` provided.

## Goal

1. Make `setup.sh` idempotent — safe to run repeatedly, only installs what's missing.
2. Cover every LSP server that `lsp.lua` configures.
3. Migrate `lsp.lua` to the Neovim 0.11 native LSP API.

## What Happened

**Setup script**: Built three `ensure_*` helpers (`ensure_npm`, `ensure_brew`, `ensure_pip`) that check `command -v` before installing. Cross-referenced every server in `lsp.lua` and added the missing ones (bash-language-server, lua-language-server, terraform-ls, tflint, zls, pyright). Removed the dead asdf/Python 3.12 section. Added graceful warnings for system-provided tools (clangd, sourcekit-lsp) and for missing package managers. Fixed the `neovim` npm package check (it doesn't provide a CLI binary, so it needs `npm list -g` instead of `command -v`).

Verified idempotency: first run installs everything, second and third runs are all green checkmarks with no side effects.

**LSP config**: Replaced `require('lspconfig')` with `vim.lsp.config()` / `vim.lsp.enable()`. Replaced the `on_attach` function with an `LspAttach` autocmd. Dropped ~15 keymaps that Neovim 0.11 now provides as built-in defaults (K, grn, gra, grr, gri, grt, gO, CTRL-S, CTRL-]).

## Decisions

- **Kept packer.nvim** despite it being unmaintained. Replacing it with lazy.nvim is a separate task.
- **Used `uv tool install`** for Python LSP tools (ruff, pyright) when uv is available — gives them isolated environments.
- **Didn't touch `init.lua`** even though `python3_host_prog` still points to `.asdf/shims/python`. That's a follow-up.
- **Preserved the pipenv/Pipfile logic** for pyright, translated to the new `on_init` / `root_dir` API shape.

## What's Next

- Update `python3_host_prog` in `init.lua` to use mise or auto-detect.
- Consider migrating from packer to lazy.nvim.
- The nvim-lspconfig plugin is still installed via packer but only used for its server definitions (loaded automatically by `vim.lsp.enable`). Could eventually drop it if server configs are inlined.
