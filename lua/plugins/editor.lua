return {
    -- File explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        lazy = false,
        priority = 1000,
        keys = {
            { "<leader>e",  "<cmd>Neotree toggle<cr>",              desc = "Explorer" },
            { "<leader>E",  "<cmd>Neotree toggle dir=getcwd()<cr>", desc = "Explorer (cwd)" },
            { "<leader>fe", "<cmd>Neotree reveal<cr>",              desc = "Explorer (reveal current file)" },
            { "<leader>fE", "<cmd>Neotree focus<cr>",               desc = "Explorer (focus)" },
        },
        config = function(_, opts)
            require("neo-tree").setup(opts)
        end,
        opts = {
            close_if_last_window = false,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            filesystem = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                hijack_netrw_behavior = "disabled",
                use_libuv_file_watcher = true,
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
            buffers = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
            },
            default_component_configs = {
                indent = {
                    indent_size = 2,
                    padding = 1,
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "󰜌",
                    default = "*",
                },
                modified = {
                    symbol = "[+]",
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                },
                git_status = {
                    symbols = {
                        added = "✚",
                        modified = "",
                        deleted = "✖",
                        renamed = "󰁕",
                        untracked = "",
                        ignored = "",
                        unstaged = "󰄱",
                        staged = "",
                        conflict = "",
                    },
                },
            },
            window = {
                position = "left",
                width = 30,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ["<space>"] = "toggle_node",
                    ["<2-LeftMouse>"] = "open",
                    ["<cr>"] = "open",
                    ["<esc>"] = "cancel",
                    ["P"] = { "toggle_preview", config = { use_float = true } },
                    ["l"] = "focus_preview",
                    ["S"] = "open_split",
                    ["s"] = "open_vsplit",
                    ["t"] = "open_tabnew",
                    ["w"] = "open_with_window_picker",
                    ["C"] = "close_node",
                    ["z"] = "close_all_nodes",
                    ["a"] = {
                        "add",
                        config = {
                            show_path = "none",
                        }
                    },
                    ["A"] = "add_directory",
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["y"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["c"] = "copy",
                    ["m"] = "move",
                    ["q"] = "close_window",
                    ["R"] = "refresh",
                    ["?"] = "show_help",
                    ["<"] = "prev_source",
                    [">"] = "next_source",
                    ["i"] = "show_file_details",
                    ["H"] = "toggle_hidden",
                },
            },
        },
    },

    -- Flash motion
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            modes = {
                char = {
                    jump_labels = true,
                    multi_line = true,
                    label = { after = { 0, 0 } },
                    highlight = { backdrop = false },
                }
            }
        },
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
            { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
    },

    -- Which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- Git signs
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },

    -- Mini plugins
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        config = function()
            require("mini.ai").setup({})
            require("mini.comment").setup({})
            require("mini.pairs").setup({})
            require("mini.surround").setup({})
        end,
    },

    -- Simple session management using built-in Neovim sessions
    {
        dir = ".", -- dummy plugin entry for session management
        name = "simple-sessions",
        config = function()
            local sessions_dir = vim.fn.stdpath("data") .. "/sessions/"
            vim.fn.mkdir(sessions_dir, "p")

            -- Function to get session file path for current directory
            local function get_session_file()
                local cwd = vim.fn.getcwd()
                local session_name = cwd:gsub("/", "%%")
                return sessions_dir .. session_name .. ".vim"
            end

            -- Auto-save session on exit
            vim.api.nvim_create_autocmd("VimLeavePre", {
                callback = function()
                    local session_file = get_session_file()
                    vim.notify("Saving session to: " .. session_file, vim.log.levels.INFO)
                    vim.cmd("mksession! " .. vim.fn.fnameescape(session_file))
                end,
            })

            -- Auto-restore session on startup
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    local argc = vim.fn.argc()
                    local cwd = vim.fn.getcwd()
                    local config_dir = vim.fn.stdpath("config")

                    vim.notify("Session autocmd triggered: argc=" .. argc .. " cwd=" .. cwd, vim.log.levels.INFO)

                    -- Restore session only if:
                    -- 1. Single argument is "." (opening directory)
                    -- 2. Not in config directory
                    local should_restore = (argc == 1 and vim.fn.argv(0) == ".")

                    if should_restore and cwd ~= config_dir then
                        local session_file = get_session_file()
                        if vim.fn.filereadable(session_file) == 1 then
                            -- Quick session restore without delays
                            vim.g.alpha_disable = true
                            vim.cmd("source " .. vim.fn.fnameescape(session_file))
                            vim.cmd("Neotree show")
                            vim.g.alpha_disable = false
                        else
                            -- No session, just open Neo-tree
                            vim.cmd("Neotree show")
                        end
                    end
                end,
                nested = true,
            })

            -- Manual session commands
            vim.keymap.set("n", "<leader>qs", function()
                local session_file = get_session_file()
                if vim.fn.filereadable(session_file) == 1 then
                    vim.cmd("source " .. vim.fn.fnameescape(session_file))
                    vim.notify("Session loaded from: " .. session_file)
                else
                    vim.notify("No session file found: " .. session_file, vim.log.levels.WARN)
                end
            end, { desc = "Restore Session" })

            vim.keymap.set("n", "<leader>qS", function()
                local session_file = get_session_file()
                vim.cmd("mksession! " .. vim.fn.fnameescape(session_file))
                vim.notify("Session saved to: " .. session_file)
            end, { desc = "Save Session" })
        end,
    },
}
