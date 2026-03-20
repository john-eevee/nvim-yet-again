return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    opts = {
      servers = {
        -- Elixir
        expert = {
          mason = false,
          cmd = { "expert", "--stdio" },
          root_markers = { "mix.exs", ".git" },
          filetypes = { "elixir", "eelixir", "heex" },
        },
        -- Dart
        dartls = {
          mason = false,
        },
        -- Web
        html = {},
        cssls = {},
        jsonls = {},
        ts_ls = {},
        -- Rust (handled by rust-tools)
        rust_analyzer = {},
        -- Go
        gopls = {},
        -- Python
        pyright = {},
        -- Java
        jdtls = {},
        -- Lua
        lua_ls = {},
        -- SQL
        sqlls = {},
      },
    },
    config = function(_, opts)
      -- Set hover border
      -- Setup LSP error logging
      local log_file = vim.fn.expand("~/.config/nvim/lsp-errors.log")
      local function log_lsp_error(level_name, message, client_id)
        local timestamp = os.date("%Y-%m-%d %H:%M:%S")
        local handle = io.open(log_file, "a")
        if handle then
          handle:write(string.format("[%s] [%s] [Client %d] %s\n", timestamp, level_name, client_id or 0, message))
          handle:close()
        end
      end

      local setup_done = {}
      local function setup(server_name)
        if setup_done[server_name] then
          return
        end
        local server_opts = opts.servers[server_name] or {}
        -- Correctly get blink.cmp capabilities
        server_opts.capabilities = require("blink.cmp").get_lsp_capabilities(server_opts.capabilities)
        local lspconfig_configs = require("lspconfig.configs")[server_name] or {}
        server_opts = vim.tbl_deep_extend("force", lspconfig_configs, server_opts)

        vim.lsp.config(server_name, server_opts)
        vim.lsp.enable(server_name)
        setup_done[server_name] = true
      end

      -- Filter servers for mason-lspconfig
      local ensure_installed = {}
      for server, server_opts in pairs(opts.servers) do
        if server_opts.mason ~= false then
          table.insert(ensure_installed, server)
        end
      end

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        handlers = {
          function(server_name)
            setup(server_name)
          end,
        },
      })

      -- Setup servers not handled by mason-lspconfig
      for server_name, _ in pairs(opts.servers) do
        setup(server_name)
      end

      -- Global diagnostics config
      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
      })
    end,
  },
}
