return {
  -- Rust Tools
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(client, bufnr)
          -- Custom keymaps for Rust
          vim.keymap.set("n", "<leader>rr", function()
            vim.cmd.RustLsp("run")
          end, { desc = "Run", buffer = bufnr })

          vim.keymap.set("n", "<leader>rt", function()
            vim.cmd.RustLsp("testables")
          end, { desc = "Run Tests", buffer = bufnr })

          vim.keymap.set("n", "<leader>rd", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Debug", buffer = bufnr })

          vim.keymap.set("n", "<leader>re", function()
            vim.cmd.RustLsp("expandMacro")
          end, { desc = "Expand Macro", buffer = bufnr })

          vim.keymap.set("n", "<leader>rc", function()
            vim.cmd.RustLsp("openCargo")
          end, { desc = "Open Cargo.toml", buffer = bufnr })

          vim.keymap.set("n", "<leader>rp", function()
            vim.cmd.RustLsp("parentModule")
          end, { desc = "Parent Module", buffer = bufnr })

          vim.keymap.set("n", "<leader>rj", function()
            vim.cmd.RustLsp("joinLines")
          end, { desc = "Join Lines", buffer = bufnr })

          vim.keymap.set("n", "<leader>rh", function()
            vim.cmd.RustLsp("hover", "actions")
          end, { desc = "Hover Actions", buffer = bufnr })

          vim.keymap.set("n", "<leader>ra", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })

          vim.keymap.set("n", "<leader>rk", function()
            vim.cmd.RustLsp("moveItem", "up")
          end, { desc = "Move Item Up", buffer = bufnr })

          vim.keymap.set("n", "<leader>rJ", function()
            vim.cmd.RustLsp("moveItem", "down")
          end, { desc = "Move Item Down", buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      },
      tools = {
        hover_actions = {
          auto_focus = true,
        },
        inlay_hints = {
          auto = true,
          only_current_line = true,
          show_parameter_hints = true,
          parameter_hints_prefix = "<- ",
          other_hints_prefix = "=> ",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          right_align_padding = 7,
          highlight = "Comment",
        },
      },
      dap = {
        adapter = {
          type = "executable",
          command = "lldb-vscode",
          name = "rt_lldb",
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
  },

  -- Crates.nvim for managing dependencies
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function()
      require("crates").setup({
        completion = {
          cmp = {
            enabled = true,
          },
        },
        popup = {
          autofocus = true,
        },
      })
    end,
  },

  -- Rust test runner
  {
    "rouge8/neotest-rust",
    dependencies = {
      "nvim-neotest/neotest",
    },
    ft = "rust",
    -- Neotest configuration moved to coding.lua
  },


}
