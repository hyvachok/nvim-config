-- Кешируем lazy handler для производительности
local lazy_handler
local function map(mode, lhs, rhs, opts)
  if not lazy_handler then
    local ok, handler = pcall(require, "lazy.core.handler")
    if ok then
      lazy_handler = handler.handlers.keys
    end
  end

  -- do not create the keymap if a lazy keys handler exists
  if lazy_handler and lazy_handler.active[lazy_handler.parse({ lhs, mode = mode }).id] then
    return
  end

  opts = opts or {}
  opts.silent = opts.silent ~= false
  if opts.remap and not vim.g.vscode then
    opts.remap = nil
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Window splits
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Buffers
map("n", "<S-h>", function()
  if vim.fn.exists(":BufferLineCyclePrev") == 2 then
    vim.cmd("BufferLineCyclePrev")
  else
    vim.cmd("bprevious")
  end
end, { desc = "Prev buffer" })
map("n", "<S-l>", function()
  if vim.fn.exists(":BufferLineCycleNext") == 2 then
    vim.cmd("BufferLineCycleNext")
  else
    vim.cmd("bnext")
  end
end, { desc = "Next buffer" })
map("n", "<leader>bd", function()
  local bd = require("mini.bufremove").delete
  if vim.bo.modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if choice == 1 then     -- Yes
      vim.cmd.write()
      bd(0)
    elseif choice == 2 then     -- No
      bd(0, true)
    end
  else
    bd(0)
  end
end, { desc = "Delete buffer" })
map("n", "<leader>bD", function()
  require("mini.bufremove").delete(0, true)
end, { desc = "Delete buffer (force)" })

-- Tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<C-PageUp>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<C-PageDown>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "gt", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "gT", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Better search (LazyVim style)
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- System clipboard integration
map("v", "<C-S-c>", '"+y', { desc = "Copy to system clipboard" })
map("n", "<C-S-c>", '"+yy', { desc = "Copy line to system clipboard" })
map({ "n", "v" }, "<C-S-v>", '"+p', { desc = "Paste from system clipboard" })
map("i", "<C-S-v>", '<C-r>+', { desc = "Paste from system clipboard" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Search (LazyVim style)
map("n", "<leader><space>", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })

-- Git (using gitsigns)
map("n", "<leader>gg", function()
  if vim.fn.executable("lazygit") == 1 then
    require("toggleterm.terminal").Terminal:new({
      cmd = "lazygit",
      direction = "float",
      hidden = true,
    }):toggle()
  else
    vim.notify("Lazygit not found", vim.log.levels.WARN)
  end
end, { desc = "Lazygit (toggleterm)" })
map("n", "<leader>Gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Git Blame" })
map("n", "<leader>GB", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Git Blame (full)" })
map("n", "<leader>Gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Git Diff" })
map("n", "<leader>GD", function()
  require("gitsigns").diffthis("~")
end, { desc = "Git Diff (~)" })
map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next Hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev Hunk" })
map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage Hunk" })
map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset Hunk" })
map("v", "<leader>hs", ":Gitsigns stage_hunk<cr>", { desc = "Stage Hunk" })
map("v", "<leader>hr", ":Gitsigns reset_hunk<cr>", { desc = "Reset Hunk" })
map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage Buffer" })
map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Undo Stage Hunk" })
map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset Buffer" })
map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Hunk" })
map("n", "<leader>hd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff This" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- Format keybinding
map("n", "<leader>fm", function()
  local conform = require("conform")
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format Document" })

map({ "n", "v" }, "<leader>mp", function()
  local conform = require("conform")
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format file or range (in visual mode)" })

-- Diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Helper function to close floating windows and navigate to diagnostics
local function close_floating_and_goto_diagnostic(goto_func, opts)
  return function()
    -- Close any existing floating windows
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative ~= "" then
        vim.api.nvim_win_close(win, false)
      end
    end
    -- Navigate to diagnostic
    goto_func(opts or {})
  end
end

map("n", "]d", close_floating_and_goto_diagnostic(vim.diagnostic.goto_next), { desc = "Next Diagnostic" })
map("n", "[d", close_floating_and_goto_diagnostic(vim.diagnostic.goto_prev), { desc = "Prev Diagnostic" })
map("n", "]e", close_floating_and_goto_diagnostic(vim.diagnostic.goto_next, { severity = vim.diagnostic.severity.ERROR }),
  { desc = "Next Error" })
map("n", "[e", close_floating_and_goto_diagnostic(vim.diagnostic.goto_prev, { severity = vim.diagnostic.severity.ERROR }),
  { desc = "Prev Error" })
map("n", "]w", close_floating_and_goto_diagnostic(vim.diagnostic.goto_next, { severity = vim.diagnostic.severity.WARN }),
  { desc = "Next Warning" })
map("n", "[w", close_floating_and_goto_diagnostic(vim.diagnostic.goto_prev, { severity = vim.diagnostic.severity.WARN }),
  { desc = "Prev Warning" })

-- Additional LSP keymaps (LazyVim style)
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map("n", "<leader>cR", function()
  local old_name = vim.fn.expand("<cword>")
  local new_name = vim.fn.input("New name: ", old_name)
  if new_name ~= "" and new_name ~= old_name then
    vim.lsp.buf.rename(new_name)
  end
end, { desc = "Rename File" })

-- Toggle options (LazyVim style)
map("n", "<leader>us", "<cmd>setlocal spell!<cr>", { desc = "Toggle Spelling" })
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle Word Wrap" })
map("n", "<leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle Diagnostics" })
map("n", "<leader>ul", "<cmd>set number!<cr>", { desc = "Toggle Line Numbers" })
map("n", "<leader>ur", "<cmd>set relativenumber!<cr>", { desc = "Toggle Relative Numbers" })
map("n", "<leader>uc", function()
  vim.opt.conceallevel = vim.opt.conceallevel:get() == 0 and 2 or 0
end, { desc = "Toggle Conceal Level" })
map("n", "<leader>uf", function()
  vim.g.autoformat = not vim.g.autoformat
  if vim.g.autoformat then
    vim.notify("Auto format enabled", vim.log.levels.INFO)
  else
    vim.notify("Auto format disabled", vim.log.levels.WARN)
  end
end, { desc = "Toggle Auto Format" })
map("n", "<leader>uh", function()
  if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end
end, { desc = "Toggle Inlay Hints" })
map("n", "<leader>uT", "<cmd>TSToggle highlight<cr>", { desc = "Toggle Treesitter Highlight" })

-- LazyVim-style window management
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })

-- Better search navigation
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Spell checking
map("n", "]s", "]s", { desc = "Next Spelling Error" })
map("n", "[s", "[s", { desc = "Prev Spelling Error" })
map("n", "z=", "z=", { desc = "Spelling Suggestions" })
map("n", "zg", "zg", { desc = "Add to Dictionary" })
map("n", "zw", "zw", { desc = "Mark as Bad Word" })

-- Terminal (handled by toggleterm plugin)
-- Additional terminal keymaps
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("n", "<leader>ft", function()
  if pcall(require, "toggleterm") then
    vim.cmd("ToggleTerm direction=float")
  else
    vim.cmd("terminal")
  end
end, { desc = "Terminal (float)" })
map("n", "<leader>fT", function()
  if pcall(require, "toggleterm") then
    vim.cmd("ToggleTerm direction=horizontal")
  else
    vim.cmd("split | terminal")
  end
end, { desc = "Terminal (horizontal)" })

-- Rust keymaps are defined in rust.lua plugin configuration
