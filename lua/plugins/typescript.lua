return {

  -- Enhanced TypeScript/JavaScript support - lightweight configuration
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      settings = {
        separate_diagnostic_server = true,
        composite_mode = "separate_diagnostic",
        tsserver_file_preferences = {
          includeCompletionsForModuleExports = true,
          includeCompletionsForImportStatements = true,
        },
      },
    },
  },

  -- Vitest test runner
  {
    "marilari88/neotest-vitest",
    dependencies = {
      "nvim-neotest/neotest",
    },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    -- Neotest configuration moved to coding.lua
  },

  -- Package.json management
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    ft = "json",
    config = function()
      require("package-info").setup({
        highlights = {
          up_to_date = { fg = "#3C4048" },
          outdated = { fg = "#d19a66" },
        },
        icons = {
          enable = true,
          style = {
            up_to_date = "|  ",
            outdated = "|  ",
          },
        },
        autostart = true,
        hide_up_to_date = false,
        hide_unstable_versions = false,
        package_manager = "npm",
      })
    end,
  },

  -- ESLint linting (disabled due to configuration issues)
  -- {
  --   "mfussenegger/nvim-lint",
  --   ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  --   config = function()
  --     local lint = require("lint")
  --     lint.linters_by_ft = {
  --       javascript = { "eslint_d" },
  --       javascriptreact = { "eslint_d" },
  --       typescript = { "eslint_d" },
  --       typescriptreact = { "eslint_d" },
  --     }
  --
  --     vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  --       callback = function()
  --         require("lint").try_lint()
  --       end,
  --     })
  --   end,
  -- },

  -- Prettier formatting is handled by formatting.lua

  -- React support
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx", "jsx" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
        per_filetype = {
          ["html"] = {
            enable_close = false,
          },
        },
      })
    end,
  },

}
