return {
  -- LSP Config
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
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(opts.servers or {}),
        handlers = {
          function(server_name)
            local server_opts = opts.servers[server_name] or {}
            server_opts.capabilities = vim.tbl_deep_extend("force", capabilities, server_opts.capabilities or {})
            lspconfig[server_name].setup(server_opts)
          end,
        },
      })

      -- Global diagnostics config
      vim.diagnostic.config({
        virtual_text = true,
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

          map("n", "gD", vim.lsp.buf.declaration, "LSP: Goto Declaration")
          map("n", "gd", vim.lsp.buf.definition, "LSP: Goto Definition")
          map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
          map("n", "gi", vim.lsp.buf.implementation, "LSP: Goto Implementation")
          map("n", "<C-k>", vim.lsp.buf.signature_help, "LSP: Signature Help")
          map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
          map("n", "gr", vim.lsp.buf.references, "LSP: References")
          map("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, "LSP: Format")
        end,
      })
    end,
  },
}
