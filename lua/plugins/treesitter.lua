return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function() vim.cmd("TSUpdate") end,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      highlight = { 
        enable = true,
        additional_vim_regex_highlighting = false,
        -- Disable for large files to maintain performance
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = { 
        enable = true,
        -- Disable for large files to maintain performance
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      ensure_installed = {
        "bash", "c", "lua", "python", "javascript", "typescript", "json", "yaml", "markdown", "vim", "vimdoc",
        "go", "gomod", "gowork", "gosum",
        "rust", "dockerfile", "toml", "ron", "regex"
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      
      -- Disable built-in vim syntax highlighting to avoid conflicts
      vim.g.loaded_matchit = 1
      vim.g.loaded_matchparen = 1
      
      -- Enable fallback syntax highlighting for large files when treesitter is disabled
      vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*",
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          local filename = vim.api.nvim_buf_get_name(buf)
          local max_filesize = 100 * 1024 -- 100 KB
          
          local ok, stats = pcall(vim.loop.fs_stat, filename)
          if ok and stats and stats.size > max_filesize then
            -- Enable basic vim syntax highlighting for large files
            vim.cmd("syntax enable")
            -- Set filetype to ensure proper syntax highlighting
            local ft = vim.bo.filetype
            if ft and ft ~= "" then
              vim.cmd("set filetype=" .. ft)
            end
          end
        end,
      })
    end,
  },
}
