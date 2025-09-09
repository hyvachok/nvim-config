-- Set leader keys before lazy setup
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Use Lua-based filetype detection (simple and robust)

-- Load configuration modules
require("config.options")
require("config.filetypes")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
