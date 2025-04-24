#!/bin/bash

set -euo pipefail

# Function to print colored output
print_message() {
    echo -e "\033[1;34m$1\033[0m"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

print_message "Setting up Neovim configuration..."

# Create .config directory if it doesn't exist
mkdir -p ~/.config

# Remove existing symlink if it exists
if [ -L ~/.config/nvim ]; then
    print_message "Removing existing symlink..."
    rm ~/.config/nvim
fi

# Create new symlink
print_message "Creating symlink to nvim_config..."
ln -nfs "$(pwd)/nvim_config" ~/.config/nvim

# Check and install uv if needed
print_message "Checking for uv installation..."
if command_exists uv; then
    echo "uv is already installed"
    uv --version
else
    print_message "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Install ruff using uv
print_message "Installing ruff..."
uv tool install ruff@latest

# Install packer.nvim if not already installed
print_message "Checking for packer.nvim..."
if [ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
    print_message "Installing packer.nvim..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# Install LSP servers
print_message "Installing LSP servers..."
if command_exists npm; then
    npm install -g typescript typescript-language-server
    npm install -g vscode-langservers-extracted
    npm install -g yaml-language-server
    npm install -g neovim
fi

# Install Python packages
print_message "Installing Python packages..."
if command_exists asdf; then
    # Install Python 3.12 if not already installed
    if ! asdf list python | grep -q "3.12"; then
        print_message "Installing Python 3.12..."
        asdf install python 3.12.2
    fi
    
    # Set Python 3.12 as global version
    asdf set -u python 3.12.2
    
    # Install Python packages using the selected version
    print_message "Installing Python packages for Neovim..."
    pip install --user msgpack
    pip install --user neovim
    pip install --user python-lsp-server
    
    # Verify the installation
    print_message "Verifying Python provider installation..."
    python -c "import neovim; print('neovim package is installed at:', neovim.__file__)"
fi

print_message "Installing plugins..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

print_message "Running Neovim healthcheck..."
nvim --headless -c 'checkhealth' -c 'quitall'

print_message "Neovim configuration setup complete!"
print_message "Your Neovim configuration is now symlinked to: $(pwd)/nvim_config"
