-- Utility function to create augroups
local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Buffer validation helper (from AstroNvim)
local function is_valid_buffer(bufnr)
  bufnr = bufnr or 0
  return vim.api.nvim_buf_is_valid(bufnr)
    and vim.bo[bufnr].buflisted
    and vim.bo[bufnr].buftype ~= "nofile"
end

-- ============================================================================
-- File Operations & Checktime
-- ============================================================================

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  desc = "Check if buffers changed on editor focus",
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Auto create directories when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_create_dir"),
  desc = "Automatically create parent directories if they don't exist when saving a file",
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- ============================================================================
-- UI Enhancements
-- ============================================================================

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  desc = "Highlight yanked text",
  pattern = "*",
  callback = function()
    (vim.hl or vim.highlight).on_yank({ timeout = 200 })
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  desc = "Resize splits if window got resized",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- ============================================================================
-- Restore Cursor & File Settings
-- ============================================================================

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  desc = "Restore last cursor position when opening a file",
  callback = function(event)
    local exclude = { "gitcommit", "gitrebase" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc_restored then
      return
    end
    vim.b[buf].last_loc_restored = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ============================================================================
-- Smart Window Management
-- ============================================================================

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  desc = "Make q close help, man, quickfix, and other special windows",
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", function()
      -- For quickfix windows (LSP references), close and return to original window
      if vim.bo.filetype == "qf" then
        local return_win = vim.g.lsp_references_return_win
        vim.cmd("cclose")
        -- Return to the window we came from if it still exists
        if return_win and vim.api.nvim_win_is_valid(return_win) then
          vim.api.nvim_set_current_win(return_win)
        end
      else
        vim.cmd("close")
      end
    end, { buffer = event.buf, silent = true, desc = "Close window" })

    -- For quickfix windows, also close when entering a reference with <CR>
    if vim.tbl_contains({ "qf" }, vim.bo[event.buf].filetype) then
      vim.keymap.set("n", "<CR>", function()
        local row = vim.api.nvim_win_get_cursor(0)[1]
        vim.cmd(row .. "cc")
        vim.cmd("cclose")
      end, { buffer = event.buf, silent = true, desc = "Jump to item and close" })
    end
  end,
})

-- Unlist quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("unlist_quickfix"),
  desc = "Unlist quickfix buffers",
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Auto-quit if only special windows are left (inspired by AstroNvim)
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("auto_quit"),
  desc = "Quit Neovim if more than one window is open and only sidebar windows are list",
  callback = function()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    if #wins == 1 then
      return
    end
    local sidebar_fts = { aerial = true, ["neo-tree"] = true, ["NvimTree"] = true }
    for _, winid in ipairs(wins) do
      if vim.api.nvim_win_is_valid(winid) then
        local bufnr = vim.api.nvim_win_get_buf(winid)
        local filetype = vim.bo[bufnr].filetype
        -- If any visible windows are not sidebars, early return
        if not sidebar_fts[filetype] then
          return
        else
          sidebar_fts[filetype] = nil
        end
      end
    end
    if #vim.api.nvim_list_tabpages() > 1 then
      vim.cmd.tabclose()
    else
      vim.cmd.qall()
    end
  end,
})

-- Auto-close quickfix when navigating away from it (disabled for now)
-- vim.api.nvim_create_autocmd("WinLeave", {
--   group = augroup("auto_close_qf"),
--   callback = function()
--     -- If we're leaving a quickfix window and it was opened by LSP references
--     if vim.bo.filetype == "qf" and vim.g.lsp_references_return_win then
--       -- Close quickfix after a delay to let navigation complete
--       vim.defer_fn(function()
--         pcall(vim.cmd, "cclose")
--         vim.g.lsp_references_return_win = nil
--       end, 150)
--     end
--   end,
-- })

-- ============================================================================
-- File Type Specific Settings
-- ============================================================================

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  desc = "Enable wrap and spell check for text files",
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    -- Defer opening folds to ensure it runs after session restore and treesitter parsing
    local buf = vim.api.nvim_get_current_buf()
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_call(buf, function()
          pcall(vim.cmd, "silent! normal! zR")
        end)
      end
    end)
  end,
})

-- Rust-specific autocmds
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("rust_settings"),
  desc = "Set Rust-specific options",
  pattern = "rust",
  callback = function()
    -- Set tab width to 4 for Rust (standard)
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

-- Cargo.toml specific settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("cargo_settings"),
  desc = "Enable crates.nvim keymaps for Cargo.toml",
  pattern = "toml",
  callback = function()
    local filename = vim.fn.expand("%:t")
    if filename == "Cargo.toml" then
      -- Enable crates.nvim features for Cargo.toml
      vim.keymap.set("n", "<leader>cu", function()
        require("crates").update_crate()
      end, { desc = "Update crate", buffer = true })

      vim.keymap.set("n", "<leader>cU", function()
        require("crates").update_all_crates()
      end, { desc = "Update all crates", buffer = true })

      vim.keymap.set("n", "<leader>cH", function()
        require("crates").open_homepage()
      end, { desc = "Open homepage", buffer = true })

      vim.keymap.set("n", "<leader>cD", function()
        require("crates").open_documentation()
      end, { desc = "Open documentation", buffer = true })
    end
  end,
})

-- Terminal settings (disable line numbers, etc.)
if vim.fn.has("nvim-0.11") ~= 1 then
  vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup("terminal_settings"),
    desc = "Disable line number/fold column/sign column for terminals",
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.signcolumn = "no"
    end,
  })
end

-- ============================================================================
-- Plugin Integration
-- ============================================================================

-- Auto-open Neo-tree when opening a directory
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("neotree_autoopen"),
  desc = "Open Neo-tree when opening a directory",
  callback = function()
    local arg = vim.fn.argv(0)
    if arg and vim.fn.isdirectory(arg) == 1 then
      vim.schedule(function()
        pcall(function()
          require("neo-tree.command").execute({ action = "show", dir = arg })
        end)
      end)
    end
  end,
})


-- Auto-close diagnostic floating windows when changing buffers or moving cursor
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufLeave", "WinEnter", "WinLeave", "CursorMoved" }, {
--   group = augroup("close_diagnostic_floats"),
--   callback = function()
--     -- Close diagnostic floating windows when navigating away
--     for _, win in ipairs(vim.api.nvim_list_wins()) do
--       if vim.api.nvim_win_is_valid(win) then
--         local config = vim.api.nvim_win_get_config(win)
--         -- Check if it's a floating window (relative positioning)
--         if config.relative ~= "" then
--           -- Check if it's likely a diagnostic window by looking at buffer content
--           local buf = vim.api.nvim_win_get_buf(win)
--           local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
--           -- Close if it looks like diagnostic content (contains error/warning patterns)
--           for _, line in ipairs(lines) do
--             if line:match("Error:") or line:match("Warning:") or line:match("Hint:") or line:match("Info:") then
--               pcall(vim.api.nvim_win_close, win, false)
--               break
--             end
--           end
--         end
--       end
--     end
--   end,
-- })
