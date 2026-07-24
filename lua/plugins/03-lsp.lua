return {
  -- LazyDev (Lua LSP library support)
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

  -- Mason (LSP installer)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },

  -- LSP servers (extendable by language plugins via opts.servers)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    opts = {
      servers = {
        lua_ls = {},
        pyright = {},
        gopls = {},
        ts_ls = {},
        jsonls = {},
        cssls = {},
        html = {},
        sqlls = {},
      },
    },
    opts_extend = { "servers" },
    config = function(_, opts)
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("blink.cmp").get_lsp_capabilities()
      )

      for server_name, server_opts in pairs(opts.servers) do
        server_opts.capabilities = vim.tbl_deep_extend("force", capabilities, server_opts.capabilities or {})
        require("lspconfig")[server_name].setup(server_opts)
      end

      -- Global diagnostics
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
      })
    end,
  },

  -- Mason-LSPConfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = function()
      -- Merge ensure_installed from all lspconfig servers
      local lspconfig_plugin = require("lazy.core.config").plugins["nvim-lspconfig"]
      local servers = lspconfig_plugin and lspconfig_plugin.opts and lspconfig_plugin.opts.servers or {}
      return {
        ensure_installed = vim.tbl_keys(servers),
      }
    end,
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },

  -- Blink completion
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
    },
    version = "*",
    build = "cargo build --release",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      completion = {
        list = {
          selection = {
            preselect = true,
            auto_select = true,
          },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        menu = {
          max_height = 10,
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind" },
            },
          },
        },
      },

      sources = {
        default = { "lsp", "buffer", "snippets", "path" },
        per_filetype = {
          sql = { "lsp", "dadbod", "buffer", "snippets" },
          mysql = { "lsp", "dadbod", "buffer", "snippets" },
          plsql = { "lsp", "dadbod", "buffer", "snippets" },
        },
        providers = {
          dadbod = {
            name = "Dadbod",
            module = "vim_dadbod_completion.blink",
            score_offset = 85,
          },
        },
      },

      snippets = { preset = "luasnip" },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },

  -- LuaSnip
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      enable_autosnippets = true,
    },
  },
}
