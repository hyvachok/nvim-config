# Neovim Configuration

Modern, feature-rich Neovim configuration with comprehensive language support, optimized for development in Go, Rust, TypeScript, and other languages.

## ✨ Highlights

### Core Features
- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) - fast and efficient
- **LSP & Tools**: Mason + lspconfig with automatic installation
- **Auto-formatting**: conform.nvim with support for 15+ languages
- **Syntax Highlighting**: Treesitter with textobjects and advanced selection
- **Fuzzy Finder**: Telescope with fzf-native integration
- **File Explorer**: Neo-tree with Git integration and custom commands
- **Session Management**: auto-session with smart restore

### UI & Appearance
- **Theme**: Tokyo Night (moon variant) with Catppuccin as alternative
- **Dashboard**: Alpha-nvim with custom DEMIVIM branding
- **Statusline**: Lualine with diagnostics, Git, and file info
- **Bufferline**: Tabs with diagnostics integration
- **Notifications**: nvim-notify for elegant notifications
- **Icons**: nvim-web-devicons + indent-blankline for visual clarity

### Language Support

#### 🦀 Rust
- **rustaceanvim**: Advanced Rust tooling with rust-analyzer
- **crates.nvim**: Cargo.toml dependency management
- **DAP**: LLDB debugger integration
- **neotest-rust**: Test runner with cargo integration

#### 🐹 Go
- **go.nvim**: Complete Go development suite
- **gopls**: Official Go language server
- **nvim-dap-go**: Delve debugger integration
- **neotest-go**: Go test runner

#### 📘 TypeScript/JavaScript
- **typescript-tools.nvim**: Enhanced TypeScript LSP
- **package-info.nvim**: package.json dependency management
- **nvim-ts-autotag**: Auto-close and rename HTML/JSX tags
- **neotest-vitest**: Vitest test runner
- **Prettier**: Auto-formatting for JS/TS/React

#### 🐍 Python
- **pyright**: Type checking and LSP
- **black + isort**: Auto-formatting

#### Other Languages
- Lua (lua_ls + stylua)
- Bash (shfmt)
- JSON, YAML, Markdown, HTML, CSS
- Docker (dockerfile support)

### Developer Tools
- **Git Integration**: gitsigns, lazygit, fugitive-style commands
- **Debugging**: nvim-dap with UI and virtual text
- **Testing**: neotest with adapters for Rust, Go, and Vitest
- **Diagnostics**: trouble.nvim for workspace-wide diagnostics
- **TODO Comments**: folke/todo-comments with Trouble integration
- **Search/Replace**: nvim-spectre for multi-file operations

### Editing Enhancements
- **Flash**: Fast motion navigation
- **Mini.nvim**: surround, comment, pairs, ai (textobjects)
- **Which-key**: Interactive keybinding help
- **Illuminate**: Highlight word under cursor
- **Treesitter Textobjects**: Advanced code navigation and selection

## 📋 Requirements

- **Neovim** >= 0.10.0
- **Git** (required)
- **ripgrep** (`rg`) - for Telescope grep
- **Nerd Font** - for icons (e.g., JetBrainsMono Nerd Font, FiraCode Nerd Font)
- **Node.js** - for TypeScript LSP and formatters
- **Make** - for compiling telescope-fzf-native (optional but recommended)

### Optional Dependencies (per language)
- **Rust**: rustup, cargo, rust-analyzer, lldb
- **Go**: go, gopls, delve
- **Python**: python3, black, isort
- **TypeScript**: npm, prettier, eslint

## 🚀 Installation

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null || true
mv ~/.local/share/nvim ~/.local/share/nvim.backup 2>/dev/null || true
mv ~/.local/state/nvim ~/.local/state/nvim.backup 2>/dev/null || true

# Clone this configuration
git clone https://github.com/your-username/nvim-config ~/.config/nvim

# Start Neovim - plugins will install automatically
nvim
```

On first launch:
1. Lazy.nvim will install all plugins
2. Mason will install configured LSP servers and tools
3. Treesitter will install language parsers

## ⚡ Quick Start

### Essential Keybindings
- **Leader key**: `Space`
- **Local leader**: `\`

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader><space>` or `<leader>ff` | Find files |
| `<leader>/` | Live grep (search in files) |
| `<leader>fm` | Format current file |
| `<leader>l` | Open Lazy (plugin manager) |
| `<C-s>` | Save file |
| `<leader>xx` | Toggle diagnostics (Trouble) |

### LSP Navigation
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>cr` | Rename symbol |
| `]d` / `[d` | Next/prev diagnostic |

### Language-Specific (Rust)
| Key | Action |
|-----|--------|
| `<leader>rr` | Run Rust program |
| `<leader>rt` | Run tests |
| `<leader>rd` | Debug |
| `<leader>re` | Expand macro |

### Language-Specific (Go)
| Key | Action |
|-----|--------|
| `<leader>gr` | Run Go program |
| `<leader>gt` | Run tests |
| `<leader>gf` | Format with gofmt |
| `<leader>ge` | Add if err snippet |

**Full keybinding list**: See `KEYBINDINGS.md`

## 🛠️ Customization

### File Structure
```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   ├── autocmds.lua    # Auto-commands
│   │   ├── keymaps.lua     # Global keybindings
│   │   ├── lazy.lua        # Plugin manager setup
│   │   ├── options.lua     # Neovim options
│   │   └── filetypes.lua   # Custom filetype detection
│   └── plugins/
│       ├── colorscheme.lua # Color themes
│       ├── lsp.lua         # LSP configuration
│       ├── treesitter.lua  # Treesitter config
│       ├── editor.lua      # Editor plugins (neo-tree, flash, etc.)
│       ├── ui.lua          # UI plugins (lualine, bufferline, etc.)
│       ├── coding.lua      # Telescope, trouble, neotest, etc.
│       ├── formatting.lua  # conform.nvim config
│       ├── util.lua        # Utility plugins
│       ├── rust.lua        # Rust-specific
│       ├── go.lua          # Go-specific
│       └── typescript.lua  # TypeScript-specific
└── spell/                  # Custom spell dictionaries
```

### Common Customizations

**Change colorscheme** (`lua/plugins/colorscheme.lua`):
```lua
-- Switch from tokyonight to catppuccin
vim.cmd([[colorscheme catppuccin]])
```

**Modify leader key** (`init.lua`):
```lua
vim.g.mapleader = " "  -- Space is default
```

**Add/remove plugins** (`lua/plugins/`):
Create new `.lua` file in `lua/plugins/` directory. Lazy.nvim will auto-detect it.

**Disable auto-format on save**:
- Toggle: `<leader>uf`
- Or set in config: `vim.g.autoformat = false`

## 🔧 Troubleshooting

### Health Check
```vim
:checkhealth
```
This will verify your Neovim setup and highlight missing dependencies.

### LSP Issues
```vim
:Mason              " Open Mason to install/update LSP servers
:LspInfo            " Check active LSP clients
:LspLog             " View LSP logs
```

### Plugin Issues
```vim
:Lazy               " Open Lazy.nvim
:Lazy sync          " Update all plugins
:Lazy clean         " Remove unused plugins
:Lazy restore       " Restore plugins from lockfile
```

### Reset Configuration
If things go wrong, you can reset everything:
```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
nvim  # Will reinstall everything
```

### Performance Issues
- Check startup time: `nvim --startuptime startup.log`
- Disable plugins incrementally in `lua/plugins/`
- Ensure you have `make` installed for telescope-fzf-native

## 📚 Learning Resources

- `:help` - Built-in Neovim help
- `:Tutor` - Interactive Neovim tutorial
- `<leader>sk` - Search keymaps (via Telescope)
- `<leader>sh` - Search help tags
- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)

## 🤝 Contributing

Feel free to submit issues or pull requests if you find bugs or have suggestions for improvements.

## 📝 License

This configuration is provided as-is for personal use. Individual plugins have their own licenses.

