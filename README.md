# 🚀 Modern Neovim Configuration

A feature-rich, performance-optimized Neovim configuration built for modern development workflows. This config provides a complete IDE-like experience with support for multiple programming languages, intelligent code completion, and a beautiful user interface.

## ✨ Features

### 🔧 Core Functionality
- **Plugin Management**: [lazy.nvim](https://github.com/folke/lazy.nvim) with lazy loading for optimal performance
- **Language Server Protocol**: Full LSP support with [Mason](https://github.com/williamboman/mason.nvim) for automatic language server management
- **Intelligent Completion**: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) with multiple sources
- **Fuzzy Finding**: [Telescope](https://github.com/nvim-telescope/telescope.nvim) for files, buffers, and live grep
- **File Explorer**: [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) with Git integration
- **Syntax Highlighting**: [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for enhanced code highlighting

### 🎨 User Interface
- **Color Scheme**: [Tokyo Night](https://github.com/folke/tokyonight.nvim) (Moon variant) with [Catppuccin](https://github.com/catppuccin/nvim) alternative
- **Status Line**: [Lualine](https://github.com/nvim-lualine/lualine.nvim) with Git and diagnostic information
- **Buffer Line**: [Bufferline](https://github.com/akinsho/bufferline.nvim) for tab-like buffer management
- **Start Screen**: [Alpha-nvim](https://github.com/goolord/alpha-nvim) for a welcoming dashboard
- **Enhanced Navigation**: [Flash.nvim](https://github.com/folke/flash.nvim) for rapid cursor movement

### 💻 Language Support
- **Rust**: Advanced support with [crates.nvim](https://github.com/saecki/crates.nvim) for dependency management
- **TypeScript/JavaScript**: Full LSP integration with intelligent tooling
- **Go**: [go.nvim](https://github.com/ray-x/go.nvim) for comprehensive Go development
- **General**: LSP support for most popular languages via Mason

### 🛠️ Developer Tools
- **Git Integration**: [Gitsigns](https://github.com/lewis6991/gitsigns.nvim) for inline Git status and actions
- **Diagnostics**: [Trouble](https://github.com/folke/trouble.nvim) for enhanced error and warning display
- **Code Formatting**: [Conform.nvim](https://github.com/stevearc/conform.nvim) for automatic code formatting
- **Snippets**: [LuaSnip](https://github.com/L3MON4D3/LuaSnip) with [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)

## 📋 Requirements

- **Neovim**: >= 0.9.0 (built with LuaJIT)
- **Git**: For plugin management and Git integration
- **Node.js**: For various language servers (optional but recommended)
- **Ripgrep**: For fast text searching with Telescope
- **A Nerd Font**: For proper icon display (recommended: [JetBrains Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts))

### Optional Dependencies
- **Python**: For Python language server support
- **Go**: For Go language server support
- **Rust**: For Rust language server support

## 🚀 Installation

### 1. Backup Existing Configuration
```bash
# Backup your current Neovim configuration
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup
```

### 2. Clone This Configuration
```bash
git clone https://github.com/hyvachok/nvim-config.git ~/.config/nvim
```

### 3. Install Neovim (if not already installed)

#### macOS
```bash
brew install neovim
```

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install neovim
```

#### Arch Linux
```bash
sudo pacman -S neovim
```

#### Windows (with Chocolatey)
```powershell
choco install neovim
```

### 4. Install Required Tools
```bash
# Install ripgrep for Telescope
# macOS
brew install ripgrep

# Ubuntu/Debian
sudo apt install ripgrep

# Arch Linux
sudo pacman -S ripgrep

# Windows
choco install ripgrep
```

### 5. First Launch
1. Start Neovim: `nvim`
2. Plugin installation will begin automatically
3. Wait for all plugins to install (you may see some errors initially - this is normal)
4. Restart Neovim after installation completes
5. Run `:checkhealth` to verify everything is working correctly

## 📖 Usage

### Quick Start
- **Leader Key**: `<Space>` (spacebar)
- **File Explorer**: `<leader>e` to toggle Neo-tree
- **Find Files**: `<leader>ff` or `<leader><space>` for Telescope file finder
- **Search Text**: `<leader>/` for live grep
- **Command Palette**: `<leader>sg` for Telescope live grep

### Language Server Setup
Language servers are automatically installed via Mason when you open supported file types. You can also manually manage them:
- `:Mason` - Open Mason UI to install/manage language servers
- `:LspInfo` - View LSP status for current buffer
- `:LspRestart` - Restart language server

## ⌨️ Keybindings

This configuration includes extensive keybindings for efficient editing. For a complete list of all available keybindings, see [KEYBINDINGS.md](./KEYBINDINGS.md).

### Essential Shortcuts
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>ff` | Find files |
| `<leader>/` | Search in files |
| `<leader>fb` | Find buffers |
| `<leader>ca` | Code actions |
| `<leader>cr` | Rename symbol |
| `<leader>fm` | Format document |
| `K` | Show hover documentation |
| `gd` | Go to definition |
| `gr` | Go to references |

## 🛠️ Customization

### Adding New Plugins
Create a new file in `lua/plugins/` or add to existing plugin files:
```lua
return {
  {
    "username/plugin-name",
    config = function()
      -- Plugin configuration
    end,
  },
}
```

### Modifying Options
Edit `lua/config/options.lua` to change Neovim settings:
```lua
vim.opt.your_option = "your_value"
```

### Custom Keybindings
Add custom keybindings in `lua/config/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>your_key", ":YourCommand<CR>", { desc = "Your description" })
```

### Changing Color Scheme
To switch to Catppuccin or another theme:
1. Edit `lua/plugins/colorscheme.lua`
2. Change the `lazy = false` setting to your preferred theme
3. Update the `vim.cmd([[colorscheme theme_name]])` line

## 📦 Plugin Overview

<details>
<summary>Core Plugins</summary>

- **lazy.nvim** - Plugin manager
- **mason.nvim** - LSP/DAP/linter/formatter installer
- **nvim-lspconfig** - LSP configuration
- **nvim-cmp** - Completion engine
- **telescope.nvim** - Fuzzy finder
- **neo-tree.nvim** - File explorer
- **treesitter** - Syntax highlighting
</details>

<details>
<summary>UI Plugins</summary>

- **tokyonight.nvim** - Color scheme
- **lualine.nvim** - Status line
- **bufferline.nvim** - Buffer tabs
- **alpha-nvim** - Start screen
- **flash.nvim** - Enhanced navigation
</details>

<details>
<summary>Development Plugins</summary>

- **gitsigns.nvim** - Git integration
- **trouble.nvim** - Diagnostics viewer
- **conform.nvim** - Code formatting
- **luasnip** - Snippet engine
- **crates.nvim** - Rust crate management
- **go.nvim** - Go development tools
</details>

## 🐛 Troubleshooting

### Common Issues

**Plugins not loading:**
```bash
# Remove plugin cache and restart
rm -rf ~/.local/share/nvim/lazy
nvim
```

**LSP not working:**
```bash
# Check LSP status
:checkhealth lsp
:Mason  # Install missing language servers
```

**Icons not displaying:**
- Install a Nerd Font and configure your terminal to use it
- Verify your terminal supports Unicode

**Performance issues:**
- Check `:checkhealth` for any issues
- Consider reducing `updatetime` in options.lua
- Disable unused language servers in Mason

## 🤝 Contributing

Feel free to submit issues and enhancement requests! This configuration is designed to be a solid foundation that can be customized to your specific needs.

## 📄 License

This configuration is open source and available under the [MIT License](LICENSE).

---

⭐ If you find this configuration helpful, please consider giving it a star!