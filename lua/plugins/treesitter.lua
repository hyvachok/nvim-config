return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function() vim.cmd("TSUpdate") end,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash", "c", "lua", "python", "javascript", "typescript", "json", "yaml", "markdown", "vim", "vimdoc",
        "go",
        "rust", "dockerfile", "toml", "ron", "regex"
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
