#!/bin/bash

set -euo pipefail

# --- Helpers ---

print_header() { echo -e "\n\033[1;34m==> $1\033[0m"; }
print_ok()     { echo -e "  \033[0;32m✓ $1\033[0m"; }
print_warn()   { echo -e "  \033[0;33m! $1\033[0m"; }
print_install(){ echo -e "  \033[0;36m+ Installing $1...\033[0m"; }

command_exists() { command -v "$1" &>/dev/null; }

# Install a binary via npm if it's not already on PATH
ensure_npm() {
    local cmd="$1"
    shift
    if command_exists "$cmd"; then
        print_ok "$cmd ($(command -v "$cmd"))"
    else
        print_install "$cmd (npm)"
        npm install -g "$@"
    fi
}

# Install a binary via brew if it's not already on PATH
ensure_brew() {
    local cmd="$1"
    local formula="${2:-$1}"
    if command_exists "$cmd"; then
        print_ok "$cmd ($(command -v "$cmd"))"
    else
        if ! command_exists brew; then
            print_warn "$cmd not found and brew is not available — skipping"
            return
        fi
        print_install "$cmd (brew)"
        brew install "$formula"
    fi
}

# Install a binary via pip/uv if it's not already on PATH
ensure_pip() {
    local cmd="$1"
    local pkg="${2:-$1}"
    if command_exists "$cmd"; then
        print_ok "$cmd ($(command -v "$cmd"))"
    else
        print_install "$cmd (pip)"
        if command_exists uv; then
            uv tool install "$pkg"
        else
            pip install --user "$pkg"
        fi
    fi
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

# --- Symlink nvim config ---

print_header "Neovim config symlink"
mkdir -p ~/.config
if [ "$(readlink ~/.config/nvim 2>/dev/null)" = "$REPO_DIR/nvim_config" ]; then
    print_ok "~/.config/nvim already points to $REPO_DIR/nvim_config"
else
    ln -nfs "$REPO_DIR/nvim_config" ~/.config/nvim
    print_ok "Linked ~/.config/nvim -> $REPO_DIR/nvim_config"
fi

# --- Core tools ---

print_header "Core tools"

# uv (Python toolchain)
if command_exists uv; then
    print_ok "uv ($(uv --version))"
else
    print_install "uv"
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# npm (needed for many LSP servers)
if command_exists npm; then
    print_ok "npm ($(npm --version))"
else
    print_warn "npm not found — npm-based LSP servers will be skipped"
fi

# --- Python packages for Neovim ---

print_header "Python packages"
ensure_pip ruff
ensure_pip pyright

# neovim python provider
if python3 -c "import neovim" 2>/dev/null; then
    print_ok "pynvim"
else
    print_install "pynvim"
    pip install --user pynvim
fi

# --- LSP servers ---
# These match the servers list in nvim_config/lua/lsp.lua:
#   bashls, clangd, lua_ls, ruff, rust_analyzer, sourcekit,
#   terraformls, ts_ls, tflint, yamlls, zls, pyright

print_header "LSP servers (npm)"
if command_exists npm; then
    ensure_npm bash-language-server       bash-language-server
    ensure_npm typescript-language-server  typescript typescript-language-server
    ensure_npm yaml-language-server        yaml-language-server
    ensure_npm vscode-json-language-server vscode-langservers-extracted
    # neovim npm package doesn't provide a CLI binary — check npm list instead
    if npm list -g neovim &>/dev/null; then
        print_ok "neovim (npm)"
    else
        print_install "neovim (npm)"
        npm install -g neovim
    fi
fi

print_header "LSP servers (brew)"
ensure_brew lua-language-server
ensure_brew terraform-ls
ensure_brew tflint
ensure_brew zls

# clangd and sourcekit-lsp come with Xcode on macOS
print_header "LSP servers (system)"
if command_exists clangd; then
    print_ok "clangd (Xcode)"
else
    print_warn "clangd not found — install Xcode Command Line Tools (xcode-select --install)"
fi

if command_exists sourcekit-lsp; then
    print_ok "sourcekit-lsp (Xcode)"
else
    print_warn "sourcekit-lsp not found — install Xcode"
fi

print_header "LSP servers (rust)"
if command_exists rust-analyzer; then
    print_ok "rust-analyzer ($(command -v rust-analyzer))"
elif command_exists rustup; then
    print_install "rust-analyzer (rustup)"
    rustup component add rust-analyzer
elif command_exists brew; then
    print_install "rust-analyzer (brew)"
    brew install rust-analyzer
else
    print_warn "rust-analyzer not found — install rustup (https://rustup.rs) and run: rustup component add rust-analyzer"
fi

# --- Packer ---

print_header "Plugin manager"
PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ -d "$PACKER_DIR" ]; then
    print_ok "packer.nvim already installed"
else
    print_install "packer.nvim"
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR"
fi

# --- Sync plugins ---

print_header "Syncing plugins"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# --- Done ---

echo ""
print_header "Setup complete!"
echo "  Config: ~/.config/nvim -> $REPO_DIR/nvim_config"
