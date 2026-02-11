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
      -- Default servers to install
      servers = {
        expert = {
          mason = false,
          cmd = { "expert_linux_amd64", "--stdio" },
          root_markers = { "mix.exs", ".git" },
          filetypes = { "elixir", "eelixir", "heex" },
        },
        dartls = {
          mason = false,
        },
        html = {},
        jdtls = {},
        jsonls = {},
      },
    },
    config = function(_, opts)
      require("mason").setup()
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
        virtual_text = {
          spacing = 4,
          prefix = "●",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- LspAttach autocommand
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local map = function(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = ev.buf, desc = desc })
          end

          -- prefer telescope pickers when available, fall back to native LSP
          local has_ts, ts = pcall(require, 'telescope.builtin')

          map("n", "gD", function()
            if has_ts and ts.lsp_type_definitions then
              ts.lsp_type_definitions()
            else
              vim.lsp.buf.declaration()
            end
          end, "LSP: Goto Declaration")

          map("n", "gd", function()
            if has_ts and ts.lsp_definitions then
              ts.lsp_definitions()
            else
              vim.lsp.buf.definition()
            end
          end, "LSP: Goto Definition")

          map("n", "K", vim.lsp.buf.hover, "LSP: Hover")

          map("n", "gi", function()
            if has_ts and ts.lsp_implementations then
              ts.lsp_implementations()
            else
              vim.lsp.buf.implementation()
            end
          end, "LSP: Goto Implementation")

          map("n", "<C-k>", vim.lsp.buf.signature_help, "LSP: Signature Help")
          map("n", "<leader>cr", vim.lsp.buf.rename, "LSP: Rename")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")

          map("n", "gr", function()
            if has_ts and ts.lsp_references then
              ts.lsp_references()
            else
              vim.lsp.buf.references()
            end
          end, "LSP: References")

          map("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, "LSP: Format")
        end,
      })
    end,
  },
}
