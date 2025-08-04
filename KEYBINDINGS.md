# Neovim Keybindings

> **Leader key**: `<space>`

## Core Navigation & Editing

### Movement
| Key | Action |
|-----|--------|
| `j`, `<Down>` | Move down (handles wrap) |
| `k`, `<Up>` | Move up (handles wrap) |
| `n` | Next search result |
| `N` | Previous search result |

### Windows
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move to left/down/up/right window |
| `<C-Up/Down/Left/Right>` | Resize window |
| `<leader>-` | Split horizontally |
| `<leader>\|` | Split vertically |
| `<leader>wd` | Close window |

### Lines & Text
| Key | Action |
|-----|--------|
| `<A-j/k>` | Move line/selection up/down |
| `</>/` | Decrease/increase indent (visual) |
| `<C-s>` | Save file |
| `<esc>` | Clear search highlight |

## Buffers & Tabs

| Key | Action |
|-----|--------|
| `<S-h/l>` | Previous/next buffer |
| `[b/]b` | Previous/next buffer (BufferLine) |
| `<leader>bd` | Delete buffer |
| `<leader>bD` | Force delete buffer |
| `<leader>bp` | Toggle pin buffer |
| `<leader>bP` | Delete non-pinned buffers |
| `<leader>bo/br/bl` | Delete other/right/left buffers |
| `gt/gT` | Next/previous tab |
| `<leader><tab><tab>` | New tab |
| `<leader><tab>d` | Close tab |

## LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Show documentation |
| `<leader>ca` | Code actions |
| `<leader>cr` | Rename |
| `<leader>cR` | Rename file |
| `<leader>fm` | Format document |
| `<leader>cd` | Show diagnostics |
| `]d/[d` | Next/previous diagnostic |
| `]e/[e` | Next/previous error |
| `]w/[w` | Next/previous warning |

## Git (prefix `<leader>G`)

| Key | Action |
|-----|--------|
| `<leader>gg` | Lazygit |
| `<leader>Gb` | Git blame |
| `<leader>GB` | Git blame (full) |
| `<leader>Gd` | Git diff |
| `<leader>GD` | Git diff (~) |
| `<leader>Gc` | Git commits |
| `<leader>Gs` | Git status |
| `]h/[h` | Next/previous hunk |
| `<leader>hs/hr` | Stage/reset hunk |
| `<leader>hS/hR` | Stage/reset buffer |
| `<leader>hp` | Preview hunk |

## Go (prefix `<leader>g`)
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
| `<leader>gI` | Go imports |
| `<leader>ge` | Go if err |
| `<leader>ga` | Go alternate |
| `<leader>gA` | Go alternate split |
| `<leader>gs` | Go fill struct |
| `<leader>gS` | Go fill switch |
| `<leader>gd` | Go doc |
| `<leader>gD` | Go debug |
| `<leader>gl` | Go lint |
| `<leader>gv` | Go vet |
| `<leader>gm` | Go mod |

## Rust (prefix `<leader>r`)
*Available only in Rust files*

| Key | Action |
|-----|--------|
| `<leader>rr` | Run |
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
| Key | Action |
|-----|--------|
| `<leader>cu` | Update crate |
| `<leader>cU` | Update all crates |
| `<leader>cH` | Open homepage |
| `<leader>cD` | Open docs |

## Telescope

| Key | Action |
|-----|--------|
| `<leader><space>` | Find files |
| `<leader>ff` | Find files |
| `<leader>/` | Live grep |
| `<leader>sg` | Live grep |
| `<leader>sw` | Search word (cwd) |
| `<leader>sW` | Search word (root) |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>fR` | Recent files (cwd) |
| `<leader>st` | Todo comments |
| `<leader>sT` | Todo/Fix/Fixme |
| `]t/[t` | Next/previous todo |

## Debug (DAP)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>da` | Run with args |
| `<leader>dC` | Run to cursor |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dO` | Step over |
| `<leader>dp` | Pause |
| `<leader>dr` | Toggle REPL |
| `<leader>dt` | Terminate |

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

## Terminal

| Key | Action |
|-----|--------|
| `<C-/>` | Toggle terminal |
| `<leader>ft` | Terminal (floating) |
| `<leader>fT` | Terminal (horizontal) |
| `<esc><esc>` | Normal mode (in terminal) |

## UI

### File Explorer
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle explorer |
| `<leader>E` | Explorer (cwd) |
| `<leader>fe` | Reveal current file |
| `<leader>fE` | Focus explorer |

### Neo-tree (inside explorer)
| Key | Action |
|-----|--------|
| `<space>` | Expand/collapse |
| `<cr>` | Open file |
| `S/s` | Open split horizontal/vertical |
| `t` | Open in tab |
| `a/A` | Add file/directory |
| `d` | Delete |
| `r` | Rename |
| `y/x/p` | Copy/cut/paste |
| `R` | Refresh |
| `H` | Toggle hidden files |

### Navigation
| Key | Action |
|-----|--------|
| `s` | Flash jump |
| `S` | Flash treesitter |

### Diagnostics
| Key | Action |
|-----|--------|
| `<leader>xx` | Diagnostics (Trouble) |
| `<leader>xX` | Buffer diagnostics |
| `<leader>cs` | Symbols |
| `<leader>cl` | LSP references |
| `<leader>xt` | Todo (Trouble) |
| `<leader>xT` | Todo/Fix/Fixme |

### Toggles
| Key | Action |
|-----|--------|
| `<leader>us` | Toggle spell check |
| `<leader>uw` | Toggle word wrap |
| `<leader>ud` | Toggle diagnostics |
| `<leader>ul` | Toggle line numbers |
| `<leader>ur` | Toggle relative numbers |
| `<leader>uf` | Toggle auto format |
| `<leader>uh` | Toggle inlay hints |
| `<leader>ui` | Show position info |

### Spell Check
| Key | Action |
|-----|--------|
| `]s/[s` | Next/previous error |
| `z=` | Suggestions |
| `zg` | Add to dictionary |
| `zw` | Mark as wrong |

## General

| Key | Action |
|-----|--------|
| `<leader>l` | Open Lazy |
| `<leader>fn` | New file |
| `<leader>qq` | Quit all |
| `<leader>qs` | Restore session |
| `<leader>qS` | Save session |
| `q` | Close (help/quickfix windows) |
