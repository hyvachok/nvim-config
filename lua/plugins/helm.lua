return {
  -- vim-helm plugin for proper Helm syntax highlighting
  {
    "towolf/vim-helm",
    -- Load immediately, not lazy
    event = { "BufReadPost", "BufNewFile" },
    -- This plugin provides filetype detection and syntax highlighting for Helm templates
    -- It uses traditional vim syntax highlighting, not treesitter
    config = function()
      -- Ensure syntax highlighting is properly loaded for helm files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "helm",
        callback = function()
          vim.cmd("syntax enable")
          vim.cmd("set syntax=helm")
        end,
      })
    end,
  },
}

