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

      -- Merge configurations from after/lsp/*.lua
      local lsp_after_path = vim.fn.stdpath("config") .. "/after/lsp"
      local files = vim.fn.globpath(lsp_after_path, "*.lua", false, true)
      for _, file in ipairs(files) do
        local server_name = vim.fn.fnamemodify(file, ":t:r")
        -- Handle 'python.lua' as 'ty' or 'pyright'
        -- Given the content uses 'ty', let's use 'ty'
        if server_name == "python" then
          server_name = "ty"
        end

        local ok, config = pcall(dofile, file)
        if ok and type(config) == "table" then
          opts.servers[server_name] = vim.tbl_deep_extend("force", opts.servers[server_name] or {}, config)
        end
      end

      -- Filter servers for mason-lspconfig
      local ensure_installed = {}
      for server, server_opts in pairs(opts.servers) do
        -- Only install if not explicitly disabled and if it's a known mason package
        -- For now, we'll just try to install everything that doesn't have mason = false
        if server_opts.mason ~= false then
          table.insert(ensure_installed, server)
        end
      end

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        handlers = {
          function(server_name)
            local server_opts = opts.servers[server_name] or {}
            server_opts.capabilities = vim.tbl_deep_extend("force", capabilities, server_opts.capabilities or {})
            
            -- Check if lspconfig has this server, otherwise it's a custom setup
            if lspconfig[server_name] then
              lspconfig[server_name].setup(server_opts)
            else
              -- Custom server setup
              vim.api.nvim_create_autocmd("FileType", {
                pattern = server_opts.filetypes or {},
                callback = function(ev)
                  vim.lsp.start(server_opts)
                end,
              })
            end
          end,
        },
      })

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
