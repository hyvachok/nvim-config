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
        "bash", "c", "lua", "python", "javascript", "typescript", "tsx", "json", "yaml", "markdown", "vim", "vimdoc",
        "go", "gomod", "gowork", "gosum",
        "rust", "dockerfile", "toml", "ron", "regex", "html", "css", "scss"
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      
      -- Ensure proper filetype detection for JavaScript files
      vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
        pattern = {"*.js", "*.jsx", "*.mjs", "*.cjs"},
        callback = function()
          vim.bo.filetype = "javascript"
        end,
      })
      
      vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
        pattern = {"*.ts", "*.tsx"},
        callback = function()
          local filename = vim.fn.expand("%:t")
          if filename:match("%.tsx$") then
            vim.bo.filetype = "typescriptreact"
          else
            vim.bo.filetype = "typescript"
          end
        end,
      })
      
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
