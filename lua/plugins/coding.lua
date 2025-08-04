return {
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>ff",      "<cmd>Telescope find_files<cr>",             desc = "Find Files" },
      { "<leader><space>", "<cmd>Telescope find_files<cr>",             desc = "Find Files" },
      { "<leader>/",       "<cmd>Telescope live_grep<cr>",              desc = "Grep" },
      { "<leader>sg",      "<cmd>Telescope live_grep<cr>",              desc = "Grep" },
      { "<leader>sw",      "<cmd>Telescope grep_string<cr>",            desc = "Word (cwd)" },
      { "<leader>sW",      "<cmd>Telescope grep_string cwd=false<cr>",  desc = "Word (root)" },
      { "<leader>fb",      "<cmd>Telescope buffers<cr>",                desc = "Buffers" },
      { "<leader>fr",      "<cmd>Telescope oldfiles<cr>",               desc = "Recent" },
      { "<leader>fR",      "<cmd>Telescope oldfiles cwd_only=true<cr>", desc = "Recent (cwd)" },
      { "<leader>Gc",      "<cmd>Telescope git_commits<cr>",            desc = "Git commits" },
      { "<leader>Gs",      "<cmd>Telescope git_status<cr>",             desc = "Git status" },
    },
    opts = {},
  },

  -- Trouble
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
    },
    opts = {},
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
    },
    opts = {},
  },

  -- DAP (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end,             desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                      desc = "Continue" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                 desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end,                         desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end,                     desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end,                          desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,                            desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end,                      desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end,                      desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end,                     desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end,                         desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                   desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,                       desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end,                     desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,              desc = "Widgets" },
    },
    config = function()
      local dap = require("dap")

      -- Setup DAP UI
      local dapui = require("dapui")
      dapui.setup()

      -- Setup virtual text
      require("nvim-dap-virtual-text").setup()

      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Rust debugging configuration
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode",
        name = "lldb"
      }

      dap.configurations.rust = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
    end,
  },

  -- Neotest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end,                          desc = "Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end,                                        desc = "Run Nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end,                            desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end,                                       desc = "Stop" },
    },
    opts = function()
      return {
        adapters = {
          require("neotest-rust") {
            args = { "--no-capture" },
            dap_adapter = "lldb",
          },
          require("neotest-go") {
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" },
          },
          require("neotest-vitest"),
        },
      }
    end,
  },
}
