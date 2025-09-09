# Neovim Config (Lazy + LSP + TS)

Opinionated Neovim setup focused on speed and good defaults. Uses lazy.nvim, LSP via mason, and Treesitter.

## Highlights

- Plugin manager: lazy.nvim
- LSP + tools: mason + lspconfig, formatting via conform.nvim
- Syntax: Treesitter (markdown enhanced); classic syntax as fallback
- Search: Telescope (+ fzf-native if available)
- Files: Neo-tree with Git signs
- UI: Tokyo Night theme, statusline/bufferline, notifications

## Requirements

- Neovim >= 0.9
- Git, ripgrep
- Nerd Font (for icons)

## Install

```bash
# Backup old config (optional)
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null || true

# Clone into config path
git clone <this-repo-url> ~/.config/nvim

# Start once to install plugins
nvim
```

## Quick Usage

- Leader: Space
- Explorer: `<leader>e`
- Find files: `<leader>ff` or `<leader><space>`
- Grep: `<leader>/`
- Format: `<leader>fm`
- Diagnostics (Trouble): `<leader>xx`
- LSP: `gd` (definition), `gr` (references), `K` (hover)

Full list: see `KEYBINDINGS.md`.

## Troubleshooting

- `:checkhealth` — verify setup
- `:Mason` — install/inspect language servers
- If plugins fail to load: remove `~/.local/share/nvim/lazy` and reopen Neovim

## Customize

- Options: `lua/config/options.lua`
- Keymaps: `lua/config/keymaps.lua`
- Plugins: `lua/plugins/`
- Theme: `lua/plugins/colorscheme.lua`

