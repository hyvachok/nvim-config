# Neovim Keybindings Reference

> **Leader key**: `Space`  
> **Local leader**: `\`

## 📑 Table of Contents
- [Core Navigation & Editing](#core-navigation--editing)
- [Buffers & Tabs](#buffers--tabs)
- [File Explorer (Neo-tree)](#file-explorer-neo-tree)
- [Search & Find (Telescope)](#search--find-telescope)
- [LSP](#lsp)
- [Git](#git)
- [Language-Specific](#language-specific)
  - [Go](#go-prefix-leaderg)
  - [Rust](#rust-prefix-leaderr)
  - [TypeScript/JavaScript](#typescriptjavascript)
- [Debugging (DAP)](#debugging-dap)
- [Testing (Neotest)](#testing-neotest)
- [Diagnostics & Trouble](#diagnostics--trouble)
- [Terminal](#terminal)
- [UI Toggles](#ui-toggles)

---

## Core Navigation & Editing

### Movement & Scrolling
| Key | Action |
|-----|--------|
| `j`, `<Down>` | Move down (handles wrapped lines) |
| `k`, `<Up>` | Move up (handles wrapped lines) |
| `n` | Next search result (centered) |
| `N` | Previous search result (centered) |
| `<C-d>` | Scroll down half-page (centered) |
| `<C-u>` | Scroll up half-page (centered) |

### Window Management
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move to left/down/up/right window |
| `<C-Up>` | Increase window height |
| `<C-Down>` | Decrease window height |
| `<C-Left>` | Decrease window width |
| `<C-Right>` | Increase window width |
| `<leader>-` | Split window horizontally |
| `<leader>\|` | Split window vertically |
| `<leader>wd` | Close window |
| `<leader>ww` | Switch to other window |
| `<leader>w-` | Split window below |
| `<leader>w\|` | Split window right |

### Lines & Text Editing
| Key | Action |
|-----|--------|
| `<A-j>` / `<A-k>` | Move line/selection down/up |
| `<` / `>` | Decrease/increase indent (visual mode) |
| `<C-s>` | Save file |
| `<esc>` | Clear search highlight |
| `<C-S-c>` | Copy to system clipboard |
| `<C-S-v>` | Paste from system clipboard |

## Buffers & Tabs

### Buffer Navigation
| Key | Action |
|-----|--------|
| `<S-h>` / `<S-l>` | Previous/next buffer |
| `[b` / `]b` | Previous/next buffer (BufferLine) |
| `<leader>fb` | Find buffer (Telescope) |

### Buffer Management
| Key | Action |
|-----|--------|
| `<leader>bd` | Delete buffer (with save prompt) |
| `<leader>bD` | Force delete buffer |
| `<leader>bp` | Toggle pin buffer |
| `<leader>bP` | Delete non-pinned buffers |
| `<leader>bo` | Delete other buffers |
| `<leader>br` | Delete buffers to the right |
| `<leader>bl` | Delete buffers to the left |

### Tabs
| Key | Action |
|-----|--------|
| `gt` / `gT` | Next/previous tab |
| `<C-PageDown>` / `<C-PageUp>` | Next/previous tab |
| `<leader><tab><tab>` | New tab |
| `<leader><tab>d` | Close tab |
| `<leader><tab>l` | Last tab |
| `<leader><tab>f` | First tab |
| `<leader><tab>]` | Next tab |
| `<leader><tab>[` | Previous tab |

## File Explorer (Neo-tree)

### Opening Neo-tree
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle Neo-tree |
| `<leader>E` | Toggle Neo-tree (cwd) |
| `<leader>fe` | Reveal current file in Neo-tree |
| `<leader>fE` | Focus Neo-tree |

### Inside Neo-tree
| Key | Action |
|-----|--------|
| `<space>` | Toggle node (expand/collapse) |
| `<cr>` | Open file |
| `S` | Open in horizontal split |
| `s` | Open in vertical split |
| `t` | Open in new tab |
| `a` | Add file |
| `A` | Add directory |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `c` | Copy |
| `m` | Move |
| `R` | Refresh |
| `H` | Toggle hidden files |
| `h` | Close node or go to parent |
| `l` | Expand node or open file |
| `O` / `<S-CR>` | Open with system app |
| `Y` | Copy path selector |
| `q` | Close Neo-tree |

---

## Search & Find (Telescope)

### File & Buffer Search
| Key | Action |
|-----|--------|
| `<leader><space>` | Find files |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fR` | Recent files (cwd only) |
| `<leader>fb` | Find buffers |
| `<leader>fn` | New file |

### Text Search
| Key | Action |
|-----|--------|
| `<leader>/` | Live grep (search in files) |
| `<leader>sg` | Live grep |
| `<leader>sw` | Search word under cursor (cwd) |
| `<leader>sW` | Search word under cursor (root) |
| `<leader>sb` | Search in current buffer |

### Other Searches
| Key | Action |
|-----|--------|
| `<leader>sa` | Search autocommands |
| `<leader>sc` | Command history |
| `<leader>sC` | Commands |
| `<leader>sd` | Document diagnostics |
| `<leader>sD` | Workspace diagnostics |
| `<leader>sh` | Help tags |
| `<leader>sH` | Highlight groups |
| `<leader>sk` | Keymaps |
| `<leader>sM` | Man pages |
| `<leader>sm` | Marks |
| `<leader>so` | Vim options |
| `<leader>sR` | Resume last search |
| `<leader>sr` | Replace in files (Spectre) |

### Telescope Mappings (inside picker)
| Key | Action |
|-----|--------|
| `<C-t>` | Open in Trouble |
| `<A-t>` | Add to Trouble |
| `<C-Up>` / `<C-Down>` | Cycle history |
| `<C-f>` / `<C-b>` | Scroll preview |
| `q` | Close (normal mode) |

---

## LSP

### Navigation
| Key | Action |
|-----|--------|
| `gd` | Go to definition (Telescope) |
| `gD` | Go to declaration |
| `gr` | Find references (Telescope) |
| `gI` | Go to implementation (Telescope) |
| `gy` | Go to type definition (Telescope) |
| `<leader>ds` | Document symbols (Telescope) |
| `<leader>ws` | Workspace symbols (Telescope) |

### Code Actions
| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>cr` | Rename symbol |
| `<leader>cR` | Rename with input |
| `<leader>fm` | Format document |
| `<leader>mp` | Format file or range |
| `<leader>cF` | Format injected languages |

### Diagnostics
| Key | Action |
|-----|--------|
| `<leader>cd` | Line diagnostics (float) |
| `]d` / `[d` | Next/previous diagnostic |
| `]e` / `[e` | Next/previous error |
| `]w` / `[w` | Next/previous warning |

### Inlay Hints & Toggles
| Key | Action |
|-----|--------|
| `<leader>uh` | Toggle inlay hints |
| `<leader>th` | Toggle inlay hints (alt) |
| `<leader>ui` | Show position info |

---

## Git

### Git Commands
| Key | Action |
|-----|--------|
| `<leader>gg` | Open Lazygit |
| `<leader>Gb` | Git blame line |
| `<leader>GB` | Git blame full |
| `<leader>Gd` | Git diff |
| `<leader>GD` | Git diff (~) |
| `<leader>Gc` | Git commits (Telescope) |
| `<leader>Gs` | Git status (Telescope) |

### Hunk Operations
| Key | Action |
|-----|--------|
| `]h` / `[h` | Next/previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hu` | Undo stage hunk |
| `<leader>hd` | Diff this |

---

## Language-Specific

### Go (prefix `<leader>g`)
*Available only in Go files*

| Key | Action |
|-----|--------|
| `<leader>gr` | Go run |
| `<leader>gt` | Go test |
| `<leader>gT` | Go test function |
| `<leader>gc` | Go coverage |
| `<leader>gb` | Go build |
| `<leader>gf` | Go format |
| `<leader>gi` | Go import |
| `<leader>gI` | Go imports (organize) |
| `<leader>ge` | Go if err (snippet) |
| `<leader>ga` | Go alternate file |
| `<leader>gA` | Go alternate split |
| `<leader>gs` | Go fill struct |
| `<leader>gS` | Go fill switch |
| `<leader>gd` | Go doc |
| `<leader>gD` | Go debug |
| `<leader>gl` | Go lint |
| `<leader>gv` | Go vet |
| `<leader>gm` | Go mod |

### Rust (prefix `<leader>r`)
*Available only in Rust files*

| Key | Action |
|-----|--------|
| `<leader>rr` | Run Rust program |
| `<leader>rt` | Run tests |
| `<leader>rd` | Debug |
| `<leader>re` | Expand macro |
| `<leader>rc` | Open Cargo.toml |
| `<leader>rp` | Parent module |
| `<leader>rj` | Join lines |
| `<leader>rh` | Hover actions |
| `<leader>ra` | Code actions |
| `<leader>rk` | Move item up |
| `<leader>rJ` | Move item down |

### Crates (Cargo.toml)
*Available in Cargo.toml files*

| Key | Action |
|-----|--------|
| `<leader>cu` | Update crate |
| `<leader>cU` | Update all crates |
| `<leader>cH` | Open crate homepage |
| `<leader>cD` | Open crate documentation |

### TypeScript/JavaScript
*Handled by typescript-tools.nvim + standard LSP keybindings*
- See [LSP](#lsp) section for navigation and actions
- Auto-formatting via Prettier (on save)
- Auto-tag closing for JSX/TSX

---


## Debugging (DAP)

### Breakpoints & Control
| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>da` | Run with args |
| `<leader>dC` | Run to cursor |
| `<leader>dt` | Terminate |
| `<leader>dp` | Pause |

### Stepping
| Key | Action |
|-----|--------|
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dO` | Step over |

### Debug UI
| Key | Action |
|-----|--------|
| `<leader>dr` | Toggle REPL |
| `<leader>ds` | Session info |
| `<leader>dw` | Widgets |
| `<leader>dg` | Go to line (no execute) |
| `<leader>dl` | Run last |
| `<leader>dj` | Down (stack) |
| `<leader>dk` | Up (stack) |

*DAP UI opens automatically when debugging starts*

---

## Testing (Neotest)

| Key | Action |
|-----|--------|
| `<leader>tt` | Run file tests |
| `<leader>tT` | Run all tests |
| `<leader>tr` | Run nearest test |
| `<leader>ts` | Toggle summary |
| `<leader>to` | Show output |
| `<leader>tO` | Toggle output panel |
| `<leader>tS` | Stop tests |

*Supports: Rust (cargo test), Go (go test), TypeScript/JavaScript (vitest)*

---

## Diagnostics & Trouble

### Trouble Commands
| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle diagnostics (Trouble) |
| `<leader>xd` | Document diagnostics (Trouble) |
| `<leader>xw` | Workspace diagnostics (Trouble) |
| `<leader>xX` | Buffer diagnostics (Trouble) |
| `<leader>cs` | Symbols (Trouble) |
| `<leader>cl` | LSP references (Trouble) |
| `<leader>xL` | Location list (Trouble) |
| `<leader>xQ` | Quickfix list (Trouble) |
| `]q` / `[q` | Next/prev trouble item |

### TODO Comments
| Key | Action |
|-----|--------|
| `<leader>st` | Search TODO comments (Telescope) |
| `<leader>sT` | Search TODO/FIX/FIXME (Telescope) |
| `<leader>xt` | TODO in Trouble |
| `<leader>xT` | TODO/FIX/FIXME in Trouble |
| `]t` / `[t` | Next/previous TODO comment |

---

## Terminal

| Key | Action |
|-----|--------|
| `<C-/>` | Toggle terminal (floating) |
| `<leader>ft` | Terminal (floating) |
| `<leader>fT` | Terminal (horizontal split) |
| `<esc><esc>` | Enter normal mode (in terminal) |

---

## UI Toggles

### Toggle Options
| Key | Action |
|-----|--------|
| `<leader>us` | Toggle spell check |
| `<leader>uw` | Toggle word wrap |
| `<leader>ud` | Toggle diagnostics |
| `<leader>ul` | Toggle line numbers |
| `<leader>ur` | Toggle relative numbers |
| `<leader>uf` | Toggle auto-format on save |
| `<leader>uh` | Toggle inlay hints |
| `<leader>uc` | Toggle conceal level |
| `<leader>uT` | Toggle Treesitter highlight |
| `<leader>un` | Dismiss all notifications |

### Spell Check
| Key | Action |
|-----|--------|
| `]s` / `[s` | Next/previous spelling error |
| `z=` | Spelling suggestions |
| `zg` | Add word to dictionary |
| `zw` | Mark word as wrong |

---

## Motion & Textobjects

### Flash Motion
| Key | Action |
|-----|--------|
| `s` | Flash jump (any visible position) |
| `S` | Flash treesitter (select syntax nodes) |

### Treesitter Textobjects Selection
*In visual/operator-pending mode*

| Key | Description |
|-----|------------|
| `af` / `if` | Around/inside function |
| `ac` / `ic` | Around/inside class |
| `ak` / `ik` | Around/inside block |
| `ao` / `io` | Around/inside loop |
| `a?` / `i?` | Around/inside conditional |
| `aa` / `ia` | Around/inside argument |

### Treesitter Navigation
| Key | Action |
|-----|--------|
| `]f` / `[f` | Next/prev function start |
| `]F` / `[F` | Next/prev function end |
| `]k` / `[k` | Next/prev block start |
| `]K` / `[K` | Next/prev block end |
| `]a` / `[a` | Next/prev argument start |
| `]A` / `[A` | Next/prev argument end |

### Treesitter Swap
| Key | Action |
|-----|--------|
| `>F` / `<F` | Swap next/prev function |
| `>K` / `<K` | Swap next/prev block |
| `>A` / `<A` | Swap next/prev argument |

### Illuminate References
| Key | Action |
|-----|--------|
| `]]` | Next reference of word under cursor |
| `[[` | Previous reference of word under cursor |

### Mini.ai Enhanced Textobjects
*Works with standard vim motions (d, c, y, v)*

Examples:
- `daa` - delete around argument
- `cif` - change inside function
- `vac` - select around class

---

## Session & Workspace

| Key | Action |
|-----|--------|
| `<leader>qq` | Quit all (saves session) |
| `<leader>qS` | Save session |
| `<leader>qs` | Restore session |
| `<leader>qD` | Delete session |
| `<leader>qQ` | Quit without saving session |

---

## Plugin Management

| Key | Action |
|-----|--------|
| `<leader>l` | Open Lazy (plugin manager) |

### Commands
- `:Lazy` - Open Lazy UI
- `:Lazy sync` - Update plugins
- `:Lazy clean` - Remove unused plugins
- `:Mason` - Open Mason (LSP/tool manager)
- `:checkhealth` - Check Neovim health

---

## Special Window Actions

### Auto-closing Windows
*The following windows can be closed with `q`:*
- Help windows
- Quickfix
- Man pages
- LSP info
- Notification windows
- Neotest output/summary
- Spectre panel

### Quickfix Enhancements
- `<CR>` - Jump to item and close quickfix
- `q` - Close quickfix and return to original window

---

## Notes

- **Leader key**: All `<leader>` mappings use `Space`
- **Which-key**: Press `<leader>` and wait to see available keybindings
- **Context-aware**: Many keybindings are only active in specific file types
- **Lazy loading**: Many plugins load on-demand to improve startup time
- **Custom mappings**: You can add your own in `lua/config/keymaps.lua`

For more details on specific plugins, use:
- `:help <plugin-name>`
- `<leader>sh` - Search help tags
- `<leader>sk` - Search keymaps
