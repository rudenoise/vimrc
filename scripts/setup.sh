#!/bin/bash

set -euo pipefail

echo "Setting up Neovim configuration..."

# Create .config directory if it doesn't exist
mkdir -p ~/.config

# Remove existing symlink if it exists
if [ -L ~/.config/nvim ]; then
    echo "Removing existing symlink..."
    rm ~/.config/nvim
fi

# Create new symlink
echo "Creating symlink to nvim_config..."
ln -nfs "$(pwd)/nvim_config" ~/.config/nvim

# install uv python package ,manager
curl -LsSf https://astral.sh/uv/install.sh | sh
# install ruff
uv tool install ruff@latest

echo "Installing packer, if not installed..."
if [ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

echo "Installing plugins..."    
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "Neovim configuration setup complete!"
echo "Your Neovim configuration is now symlinked to: $(pwd)/nvim_config"
