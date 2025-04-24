# Neovim Configuration

A modern Neovim configuration with Lua-based setup, featuring LSP support, filetype-specific configurations, and a streamlined development environment.

## Prerequisites

- [Neovim](https://neovim.io/) (latest stable version)
- [asdf](https://asdf-vm.com/) (version manager)
- [Node.js](https://nodejs.org/) (for LSP servers)
- [Python](https://www.python.org/) (3.12.2 recommended)

## Installation

1. Clone this repository:
   ```bash
   git clone <your-repo-url>
   cd <repo-name>
   ```

2. Run the setup script:
   ```bash
   ./scripts/setup.sh
   ```

The setup script will:
- Create necessary symlinks
- Install required Python packages
- Set up LSP servers
- Install and configure plugins
- Run a healthcheck

## Features

### Language Support
- Python (with LSP)
- Lua (with LSP)
- TypeScript/JavaScript (with LSP)
- YAML (with LSP)

### Key Features
- Filetype-specific configurations
- LSP integration
- Code completion
- Diagnostics and error handling
- Formatting support
- Modern UI components

## Configuration Structure

```
nvim_config/
├── ftplugin/          # Filetype-specific configurations
│   ├── lua.lua       # Lua configuration
│   └── python.lua    # Python configuration
├── lua/              # Core Lua configurations
│   ├── plugins.lua   # Plugin management
│   ├── lsp.lua      # LSP configuration
│   └── completion.lua # Completion setup
└── init.lua         # Main configuration file
```

## Key Bindings

### LSP Navigation
- `gd` - Go to definition
- `K` - Show documentation
- `gi` - Go to implementation
- `gr` - Show references
- `<leader>rn` - Rename symbol
- `<leader>f` - Format code
- `<leader>ca` - Code actions

### Diagnostics
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `<space>d` - Show diagnostics list

## Troubleshooting

If you encounter any issues:

1. Run the setup script again:
   ```bash
   ./scripts/setup.sh
   ```

2. Check Neovim's health:
   ```bash
   nvim --headless -c 'checkhealth' -c 'quitall'
   ```

3. Verify Python provider:
   ```bash
   python -c "import neovim; print('neovim package is installed at:', neovim.__file__)"
   ```

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the MIT License - see the LICENSE file for details.
