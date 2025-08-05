return {
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      },
    },
    keys = {
      { "<leader>ff",      "<cmd>Telescope find_files<cr>",                desc = "Find Files" },
      { "<leader><space>", "<cmd>Telescope find_files<cr>",                desc = "Find Files" },
      { "<leader>/",       "<cmd>Telescope live_grep<cr>",                 desc = "Grep" },
      { "<leader>sg",      "<cmd>Telescope live_grep<cr>",                 desc = "Grep" },
      { "<leader>sw",      "<cmd>Telescope grep_string<cr>",               desc = "Word (cwd)" },
      { "<leader>sW",      "<cmd>Telescope grep_string cwd=false<cr>",     desc = "Word (root)" },
      { "<leader>fb",      "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
      { "<leader>fr",      "<cmd>Telescope oldfiles<cr>",                  desc = "Recent" },
      { "<leader>fR",      "<cmd>Telescope oldfiles cwd_only=true<cr>",    desc = "Recent (cwd)" },
      { "<leader>Gc",      "<cmd>Telescope git_commits<cr>",               desc = "Git commits" },
      { "<leader>Gs",      "<cmd>Telescope git_status<cr>",                desc = "Git status" },
      -- LSP
      { "gd",              "<cmd>Telescope lsp_definitions<cr>",           desc = "Goto Definition" },
      { "gr",              "<cmd>Telescope lsp_references<cr>",            desc = "References" },
      { "gI",              "<cmd>Telescope lsp_implementations<cr>",       desc = "Goto Implementation" },
      { "gy",              "<cmd>Telescope lsp_type_definitions<cr>",      desc = "Goto Type Definition" },
      -- Search
      { "<leader>sa",      "<cmd>Telescope autocommands<cr>",              desc = "Auto Commands" },
      { "<leader>sb",      "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc",      "<cmd>Telescope command_history<cr>",           desc = "Command History" },
      { "<leader>sC",      "<cmd>Telescope commands<cr>",                  desc = "Commands" },
      { "<leader>sd",      "<cmd>Telescope diagnostics bufnr=0<cr>",       desc = "Document diagnostics" },
      { "<leader>sD",      "<cmd>Telescope diagnostics<cr>",               desc = "Workspace diagnostics" },
      { "<leader>sh",      "<cmd>Telescope help_tags<cr>",                 desc = "Help Pages" },
      { "<leader>sH",      "<cmd>Telescope highlights<cr>",                desc = "Search Highlight Groups" },
      { "<leader>sk",      "<cmd>Telescope keymaps<cr>",                   desc = "Key Maps" },
      { "<leader>sM",      "<cmd>Telescope man_pages<cr>",                 desc = "Man Pages" },
      { "<leader>sm",      "<cmd>Telescope marks<cr>",                     desc = "Jump to Mark" },
      { "<leader>so",      "<cmd>Telescope vim_options<cr>",               desc = "Options" },
      { "<leader>sR",      "<cmd>Telescope resume<cr>",                    desc = "Resume" },
    },
    opts = function()
      local actions = require("telescope.actions")

      local open_with_trouble = function(...)
        return require("trouble.sources.telescope").open(...)
      end
      local add_to_trouble = function(...)
        return require("trouble.sources.telescope").add(...)
      end

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = add_to_trouble,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
            n = {
              ["q"] = actions.close,
              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = add_to_trouble,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")
    end,
  },

  -- Trouble
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      modes = {
        preview_float = {
          mode = "diagnostics",
          preview = {
            type = "float",
            relative = "editor",
            border = "rounded",
            title = "Preview",
            title_pos = "center",
            position = { 0, -2 },
            size = { width = 0.3, height = 0.3 },
            zindex = 200,
          },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                                     desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",                        desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                             desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",              desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                                         desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                                          desc = "Quickfix List (Trouble)" },
      { "[q",         function() require("trouble").prev({ skip_groups = true, jump = true }) end, desc = "Previous trouble/quickfix item" },
      { "]q",         function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Next trouble/quickfix item" },
    },
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
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
      {
        "<leader>da",
        function()
          local function get_args()
            local co = coroutine.running()
            if co then
              return coroutine.create(function()
                local args = {}
                local i = 1
                while true do
                  local arg = vim.fn.input("Argument " .. i .. ": ")
                  if arg == "" then
                    break
                  end
                  table.insert(args, arg)
                  i = i + 1
                end
                return args
              end)
            else
              local args = {}
              local i = 1
              while true do
                local arg = vim.fn.input("Argument " .. i .. ": ")
                if arg == "" then
                  break
                end
                table.insert(args, arg)
                i = i + 1
              end
              return args
            end
          end
          require("dap").continue({ before = get_args })
        end,
        desc = "Run with Args"
      },
      { "<leader>dC", function() require("dap").run_to_cursor() end,    desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end,            desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end,        desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end,             desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,               desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end,         desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end,         desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end,        desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end,            desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,      desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,          desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end,        desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
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
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-go",
      "marilari88/neotest-vitest",
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
          require("neotest-rust")({
            args = { "--no-capture" },
            dap_adapter = "lldb",
          }),
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" },
          }),
          require("neotest-vitest"),
        },
      }
    end,
  },
}
