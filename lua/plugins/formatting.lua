return {
  -- Formatting
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    init = function()
      -- Install conform formatters on VeryLazy
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.g.autoformat = true
      end, {
        desc = "Enable autoformat-on-save",
      })
      vim.api.nvim_create_user_command("FormatDisable", function()
        vim.g.autoformat = false
      end, {
        desc = "Disable autoformat-on-save",
      })
    end,
    opts = function()
      ---@class ConformOpts
      local opts = {
        -- LazyVim will use these options when formatting with the conform.nvim formatter
        default_format_opts = {
          timeout_ms = 3000,
          async = false,       -- not recommended to change
          quiet = false,       -- not recommended to change
          lsp_fallback = true, -- not recommended to change
        },
        formatters_by_ft = {
          lua = { "stylua" },
          fish = { "fish_indent" },
          sh = { "shfmt" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          vue = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          less = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          jsonc = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          handlebars = { "prettier" },
          python = { "isort", "black" },
          rust = { "rustfmt" },
          go = { "goimports", "gofmt" },
        },
        -- The options you set here will be merged with the builtin formatters.
        -- You can also define any custom formatters here.
        ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
        formatters = {
          injected = { options = { ignore_errors = true } },
        },
      }
      return opts
    end,
    config = function(_, opts)
      require("conform").setup(opts)

      -- Format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          -- Check if autoformat is enabled (default true)
          if vim.g.autoformat == false then
            return
          end

          -- Don't format if the buffer is not a normal file
          if vim.bo[args.buf].buftype ~= "" then
            return
          end

          require("conform").format({ bufnr = args.buf })
        end,
      })

      -- Set default autoformat to true
      if vim.g.autoformat == nil then
        vim.g.autoformat = true
      end
    end,
  },
}
