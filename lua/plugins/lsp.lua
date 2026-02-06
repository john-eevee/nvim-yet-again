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
      require("mason").setup()

      -- Merge configurations from after/lsp/*.lua
      local lsp_after_path = vim.fn.stdpath("config") .. "/after/lsp"
      local files = vim.fn.globpath(lsp_after_path, "*.lua", false, true)
      for _, file in ipairs(files) do
        local server_name = vim.fn.fnamemodify(file, ":t:r")
        if server_name == "python" then
          server_name = "ty"
        end

        local ok, config = pcall(dofile, file)
        if ok and type(config) == "table" then
          opts.servers[server_name] = vim.tbl_deep_extend("force", opts.servers[server_name] or {}, config)
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

        -- Use native vim.lsp APIs for Neovim 0.11
        local has_native, _ = pcall(require, "vim.lsp.config")
        if has_native then
          vim.lsp.config[server_name] = server_opts
          pcall(vim.lsp.enable, server_name)
        else
          -- Fallback for older versions or very custom servers
          local filetypes = server_opts.filetypes
          if not filetypes then
            local ok, configs = pcall(require, "lspconfig.configs")
            if ok and configs[server_name] then
              filetypes = configs[server_name].default_config.filetypes
            end
          end

          if filetypes then
            vim.api.nvim_create_autocmd("FileType", {
              pattern = filetypes,
              callback = function(ev)
                local config = vim.tbl_deep_extend("force", {
                  name = server_name,
                  root_dir = server_opts.root_dir or (server_opts.root_patterns and vim.fs.root(ev.buf, server_opts.root_patterns)),
                }, server_opts)
                vim.lsp.start(config)
              end,
            })
          end
        end
        
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
