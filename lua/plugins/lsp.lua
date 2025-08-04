return {
    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- LSP keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("gd", vim.lsp.buf.definition, "Goto Definition")
                    map("gr", function()
                        -- Save current window ID before opening references
                        vim.g.lsp_references_return_win = vim.api.nvim_get_current_win()
                        vim.lsp.buf.references()
                    end, "Goto References")
                    map("K", vim.lsp.buf.hover, "Hover Documentation")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
                    map("<leader>cr", vim.lsp.buf.rename, "Rename")
                    map("<leader>fm", function()
                        vim.lsp.buf.format({ async = true })
                    end, "Format Document")
                    map("gI", vim.lsp.buf.implementation, "Goto Implementation")
                    map("gy", vim.lsp.buf.type_definition, "Type Definition")
                end,
            })

            -- Setup capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            if pcall(require, "cmp_nvim_lsp") then
                capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
            end

            -- Setup LSP servers with lazy loading by filetype
            local servers = {
                lua_ls = {
                    filetypes = { "lua" },
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    "${3rd}/luv/library",
                                    unpack(vim.api.nvim_get_runtime_file("", true)),
                                },
                            },
                            completion = { callSnippet = "Replace" },
                            diagnostics = { disable = { "missing-fields" } },
                        },
                    },
                },
                -- Only essential servers for better performance
                ts_ls = { filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" } },
                pyright = { filetypes = { "python" } },
                -- rust_analyzer is handled by rustaceanvim plugin
            }

            -- Create autocmd to setup LSP only when filetype matches
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(event)
                    local filetype = vim.bo[event.buf].filetype
                    for server, config in pairs(servers) do
                        if config.filetypes and vim.tbl_contains(config.filetypes, filetype) then
                            local server_config = vim.tbl_deep_extend("force", {
                                capabilities = capabilities,
                            }, config)
                            server_config.filetypes = nil -- Remove filetypes from config

                            local ok, err = pcall(require("lspconfig")[server].setup, server_config)
                            if not ok then
                                vim.notify("Failed to setup " .. server .. ": " .. tostring(err), vim.log.levels.WARN)
                            end
                        end
                    end
                end,
            })
        end,
    },

    -- Mason
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {},
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            local cmp = require("cmp")
            return {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                },
            }
        end,
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
