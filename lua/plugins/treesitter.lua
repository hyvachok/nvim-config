return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function() vim.cmd("TSUpdate") end,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      auto_install = true,
      highlight = { 
        enable = true,
        -- Enable classic Vim regex highlighting alongside Treesitter for markdown/MDX
        additional_vim_regex_highlighting = { "markdown" },
        -- Disable only for large files
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
        "bash", "c", "lua", "python", "javascript", "typescript", "tsx", "json", "yaml",
        "markdown", "markdown_inline", "vim", "vimdoc",
        "go", "gomod", "gowork", "gosum",
        "rust", "dockerfile", "toml", "ron", "regex", "html", "css", "scss"
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      
      -- Rely on Neovim's built-in filetype detection and global syntax enable.
    end,
  },
}
