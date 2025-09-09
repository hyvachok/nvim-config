local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
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
    end, { buffer = event.buf, silent = true })

    -- For quickfix windows, also close when entering a reference with <CR>
    if vim.tbl_contains({ "qf" }, vim.bo[event.buf].filetype) then
      vim.keymap.set("n", "<CR>", function()
        -- Get the line under cursor and jump to it
        local line = vim.api.nvim_get_current_line()
        local row = vim.api.nvim_win_get_cursor(0)[1]

        -- Use the built-in quickfix command to jump
        vim.cmd(row .. "cc")

        -- Close quickfix window after jumping
        vim.cmd("cclose")
      end, { buffer = event.buf, silent = true })
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

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    -- Defer opening folds to ensure it runs after session restore and treesitter parsing
    -- Open all folds in the same buffer that triggered the event.
    -- Use normal! to avoid invoking plugin mappings (e.g. neo-tree maps 'z').
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

-- Auto create dir when saving a file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Rust-specific autocmds
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("rust_settings"),
  pattern = "rust",
  callback = function()
    -- Set tab width to 4 for Rust (standard)
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true

    -- Format on save disabled for better performance
    -- Use <leader>fm to format manually when needed
  end,
})

-- Cargo.toml specific settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("cargo_settings"),
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

-- Auto-open Neo-tree when opening a directory
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("neotree_autoopen"),
  callback = function()
    local arg = vim.fn.argv(0)
    if arg and vim.fn.isdirectory(arg) == 1 then
      -- We're opening a directory, so open neo-tree and show it
      vim.schedule(function()
        require("neo-tree.command").execute({ action = "show", dir = arg })
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
