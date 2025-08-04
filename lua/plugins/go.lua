return {
  -- Go Tools
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        goimports = "gopls",
        gofmt = "gofumpt",
        max_line_len = 120,
        tag_transform = false,
        test_dir = "",
        comment_placeholder = "   ",
        lsp_cfg = true,
        lsp_gofumpt = true,
        lsp_on_attach = function(client, bufnr)
          -- Custom keymaps for Go
          vim.keymap.set("n", "<leader>gr", "<cmd>GoRun<cr>", { desc = "Go Run", buffer = bufnr })
          vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<cr>", { desc = "Go Test", buffer = bufnr })
          vim.keymap.set("n", "<leader>gT", "<cmd>GoTestFunc<cr>", { desc = "Go Test Function", buffer = bufnr })
          vim.keymap.set("n", "<leader>gc", "<cmd>GoCoverage<cr>", { desc = "Go Coverage", buffer = bufnr })
          vim.keymap.set("n", "<leader>gb", "<cmd>GoBuild<cr>", { desc = "Go Build", buffer = bufnr })
          vim.keymap.set("n", "<leader>gf", "<cmd>GoFmt<cr>", { desc = "Go Format", buffer = bufnr })
          vim.keymap.set("n", "<leader>gi", "<cmd>GoImport<cr>", { desc = "Go Import", buffer = bufnr })
          vim.keymap.set("n", "<leader>gI", "<cmd>GoImports<cr>", { desc = "Go Imports", buffer = bufnr })
          vim.keymap.set("n", "<leader>ge", "<cmd>GoIfErr<cr>", { desc = "Go If Err", buffer = bufnr })
          vim.keymap.set("n", "<leader>ga", "<cmd>GoAlt<cr>", { desc = "Go Alternate", buffer = bufnr })
          vim.keymap.set("n", "<leader>gA", "<cmd>GoAltV<cr>", { desc = "Go Alternate Split", buffer = bufnr })
          vim.keymap.set("n", "<leader>gs", "<cmd>GoFillStruct<cr>", { desc = "Go Fill Struct", buffer = bufnr })
          vim.keymap.set("n", "<leader>gS", "<cmd>GoFillSwitch<cr>", { desc = "Go Fill Switch", buffer = bufnr })
          vim.keymap.set("n", "<leader>gd", "<cmd>GoDoc<cr>", { desc = "Go Doc", buffer = bufnr })
          vim.keymap.set("n", "<leader>gD", "<cmd>GoDebug<cr>", { desc = "Go Debug", buffer = bufnr })
          vim.keymap.set("n", "<leader>gl", "<cmd>GoLint<cr>", { desc = "Go Lint", buffer = bufnr })
          vim.keymap.set("n", "<leader>gv", "<cmd>GoVet<cr>", { desc = "Go Vet", buffer = bufnr })
          vim.keymap.set("n", "<leader>gm", "<cmd>GoMod<cr>", { desc = "Go Mod", buffer = bufnr })
        end,
        lsp_keymaps = false,
        trouble = true,
        test_runner = "go",
        verbose_tests = true,
        run_in_floaterm = false,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },

  -- Go debugging support
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
          },
        },
        delve = {
          path = "dlv",
          initialize_timeout_sec = 20,
          port = "${port}",
          args = {},
          build_flags = "",
        },
      })
    end,
  },

  -- Go test runner
  {
    "nvim-neotest/neotest-go",
    dependencies = {
      "nvim-neotest/neotest",
    },
    ft = "go",
    -- Neotest configuration moved to coding.lua
  },

}
