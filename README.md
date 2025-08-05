# 🚀 Neovim Configuration

> **LazyVim Compatible** - Optimized for maximum compatibility with LazyVim while maintaining performance and simplicity.

## ✨ Features

### 🔧 Core Functionality
- **Plugin Management**: [lazy.nvim](https://github.com/folke/lazy.nvim) with optimized lazy loading
- **Language Server Protocol**: Full LSP support with [Mason](https://github.com/williamboman/mason.nvim) and automatic server installation
- **Intelligent Completion**: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) with multiple sources and enhanced UI
- **Code Formatting**: [conform.nvim](https://github.com/stevearc/conform.nvim) with auto-format on save
- **Fuzzy Finding**: [Telescope](https://github.com/nvim-telescope/telescope.nvim) with fzf-native for blazing fast search
- **File Explorer**: [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) with Git integration
- **Syntax Highlighting**: [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for enhanced code highlighting

### 🎨 User Interface  
- **Color Scheme**: [Tokyo Night](https://github.com/folke/tokyonight.nvim) (Moon variant) with [Catppuccin](https://github.com/catppuccin/nvim) alternative
- **Status Line**: [Lualine](https://github.com/nvim-lualine/lualine.nvim) with Git and diagnostic information
- **Buffer Line**: [Bufferline](https://github.com/akinsho/bufferline.nvim) for tab-like buffer management  
- **Start Screen**: [Alpha-nvim](https://github.com/goolord/alpha-nvim) for a welcoming dashboard
- **Enhanced Navigation**: [Flash.nvim](https://github.com/folke/flash.nvim) for rapid cursor movement
- **Notifications**: [nvim-notify](https://github.com/rcarriga/nvim-notify) for beautiful notifications
- **Indent Guides**: [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) with active scope highlighting

### 💻 Language Support
- **Rust**: Advanced support with [crates.nvim](https://github.com/saecki/crates.nvim) for dependency management
- **TypeScript/JavaScript**: Full LSP integration with intelligent tooling
- **Go**: [go.nvim](https://github.com/ray-x/go.nvim) for comprehensive Go development
- **General**: LSP support for most popular languages via Mason

### 🛠️ Developer Tools
- **Git Integration**: [Gitsigns](https://github.com/lewis6991/gitsigns.nvim) for inline Git status and actions
- **Diagnostics**: [Trouble](https://github.com/folke/trouble.nvim) for enhanced error and warning display
- **Code Formatting**: [Conform.nvim](https://github.com/stevearc/conform.nvim) with comprehensive language support and auto-format
- **Snippets**: [LuaSnip](https://github.com/L3MON4D3/LuaSnip) with [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- **Search & Replace**: [nvim-spectre](https://github.com/nvim-pack/nvim-spectre) for project-wide search and replace
- **Session Management**: [persistence.nvim](https://github.com/folke/persistence.nvim) for automatic session restoration
- **Word Highlighting**: [vim-illuminate](https://github.com/RRethy/vim-illuminate) automatically highlights word under cursor

### 🚀 Performance Optimizations
- **Lazy Loading**: All plugins are optimally lazy-loaded for fast startup times
- **Smart Caching**: Enhanced caching configuration for better performance  
- **Minimal Runtime**: Disabled unnecessary built-in plugins
- **Efficient LSP**: Mason-lspconfig integration with on-demand server installation

## 🔄 Migration from LazyVim

This configuration is designed to be **fully compatible** with LazyVim, making migration seamless:

### ✅ What's Compatible
- **All keybindings** follow LazyVim conventions 
- **Plugin structure** matches LazyVim organization
- **LSP setup** uses the same patterns as LazyVim
- **Formatting** uses conform.nvim like LazyVim
- **Session management** uses persistence.nvim like LazyVim

### 🚀 Easy Migration Steps
1. **From LazyVim**: Simply clone this config - all your muscle memory will work!
2. **To LazyVim**: Your knowledge transfers directly - same keys, same patterns

### 🎯 Key Differences from LazyVim
- **Lighter weight**: Fewer plugins for better performance
- **Rust-focused**: Enhanced support for Rust development
- **Simplified**: Less complexity while maintaining power

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

### 4. Install Required Tools
```bash
# Install ripgrep for Telescope
# macOS
brew install ripgrep

# Ubuntu/Debian
sudo apt install ripgrep
```

### 5. First Launch
1. Start Neovim: `nvim`
2. Plugin installation will begin automatically
3. Wait for all plugins to install (you may see some errors initially - this is normal)
4. Restart Neovim after installation completes
5. Run `:checkhealth` to verify everything is working correctly

## 📖 Usage

### Quick Start
- **Leader Key**: `<Space>` (spacebar) - exactly like LazyVim
- **File Explorer**: `<leader>e` to toggle Neo-tree
- **Find Files**: `<leader>ff` or `<leader><space>` for Telescope file finder  
- **Search Text**: `<leader>/` for live grep
- **Format Code**: `<leader>fm` to format current file
- **Search & Replace**: `<leader>sr` for project-wide search and replace

### Essential LazyVim-Compatible Shortcuts
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>ff` | Find files |
| `<leader>/` | Search in files |
| `<leader>fb` | Find buffers |
| `<leader>ca` | Code actions |
| `<leader>cr` | Rename symbol |
| `<leader>fm` | Format document |  
| `<leader>sr` | Search & replace |
| `<leader>xx` | Show diagnostics |
| `<leader>bd` | Delete buffer |
| `<leader>qs` | Restore session |
| `K` | Show hover documentation |
| `gd` | Go to definition |
| `gr` | Go to references |

### Language Server Setup
Language servers are automatically installed via Mason when you open supported file types. You can also manually manage them:
- `:Mason` - Open Mason UI to install/manage language servers
- `:LspInfo` - View LSP status for current buffer
- `:LspRestart` - Restart language server

### Code Formatting
This configuration uses **conform.nvim** (same as LazyVim) for formatting:
- **Auto-format on save** is enabled by default
- `:FormatDisable` - Disable auto-formatting
- `:FormatEnable` - Re-enable auto-formatting
- `<leader>fm` - Manual format current file

### Session Management
Sessions are automatically saved and restored using **persistence.nvim**:
- Sessions save automatically when you exit Neovim
- `<leader>qs` - Restore last session
- `<leader>ql` - Load last session
- `<leader>qd` - Don't save current session

## ⌨️ Keybindings

This configuration uses **exactly the same keybindings as LazyVim** for seamless migration. For a complete list of all available keybindings, see [KEYBINDINGS.md](./KEYBINDINGS.md).

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

## 📄 License

This configuration is open source and available under the [MIT License](LICENSE).
