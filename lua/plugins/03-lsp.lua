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
  --
  -- Neovim 0.11+ starts servers itself: register each entry with
  -- vim.lsp.config() and hand the names to vim.lsp.enable(). nvim-lspconfig v2
  -- retired its own framework, so the old require("lspconfig")[name].setup()
  -- call silently did nothing (and is removed outright in v3).
  --
  -- NOTE: no `opts_extend` here. lazy.nvim's opts_extend *list*-extends the
  -- value, which drops keys from a string-keyed table like `servers`; the
  -- default deep merge is what lets language plugins add to it.
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
    config = function(_, opts)
      -- Applies to every server, including the ones configured elsewhere
      -- (Elixir in init.lua, jdtls in 07-lang-java.lua).
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
      })

      for server_name, server_opts in pairs(opts.servers) do
        vim.lsp.config(server_name, server_opts)
      end
      vim.lsp.enable(vim.tbl_keys(opts.servers))

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
      -- Every server declared in the nvim-lspconfig spec (including the ones
      -- added by language plugins) should be installed by mason. `plugin.opts`
      -- only holds the last matching spec's table, so read the merged opts.
      local plugin = require("lazy.core.config").plugins["nvim-lspconfig"]
      local servers = plugin and require("lazy.core.plugin").values(plugin, "opts").servers or {}
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
            auto_insert = true,
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
