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
        ty = {
          cmd = { "ty", "server" },
          filetypes = { "python" },
          root_dir = function(fname)
            return vim.fs.root(fname, {
              "pyproject.toml",
              "setup.py",
              "setup.cfg",
              "pyrightconfig.json",
              "typings",
              ".git",
            })
          end,
          settings = {
            ty = {
              typeCheckingMode = "standard",
              diagnosticMode = "workspace",
            },
          },
        },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              assist = {
                expressionFillDefault = "todo",
              },
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--all-targets", "--all-features" },
              },
              procMacro = {
                enable = true,
              },
              runnables = {
                command = "cargo",
              },
              inlayHints = {
                enable = true,
                chainingHints = true,
                closureReturnTypeHints = "with_block",
                closingBraceHints = true,
                lifetimeElisionHints = {
                  enable = "skip_trivial",
                  useParameterNames = true,
                },
                maxLength = nil,
                reborrowHints = "mutable",
                renderColons = true,
                typeHints = {
                  enable = true,
                  hideClosureInitialization = false,
                  hideNamedConstructor = false,
                },
              },
            },
          },
        },
        dartls = {
          cmd = { "dart", "language-server", "--protocol=lsp" },
          filetypes = { "dart" },
          init_options = {
            closingLabels = true,
            flutterOutline = true,
            outline = true,
          },
          settings = {
            dart = {
              completeFunctionCalls = true,
              enableSnippets = true,
              enableSdkFormatter = true,
              lineLength = 80,
            },
          },
        },
        elixirls = {
          cmd = { "elixir-ls" },
          settings = {
            elixirLS = {
              dialyzerEnabled = true,
              fetchDeps = false,
              enableTestLenses = true,
              suggestSpecs = true,
            },
          },
        },
        jdtls = {
          settings = {
            java = {
              project = {
                referencedLibraries = {
                  "$JAVA_HOME/lib/**/*.jar",
                },
              },
              eclipse = {
                downloadSources = true,
              },
              maven = {
                downloadSources = true,
              },
              implementation = {
                searchAllProjectsScope = true,
              },
              referencesCodeLens = {
                enabled = true,
              },
              signatureHelp = {
                enabled = true,
                description = {
                  enabled = true,
                },
              },
              contentProvider = "fernflower",
              autobuild = {
                enabled = true,
              },
              saveActions = {
                organizeImports = true,
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
              codeGeneration = {
                toString = {
                  template = "${object}.toString()",
                },
                hashCodeEquals = {
                  useInstanceof = true,
                  useJava7Objects = true,
                },
                useBlocks = true,
              },
              configuration = {
                runtimes = {
                  {
                    name = "JavaSE-11",
                    path = os.getenv("JAVA_HOME") or "/usr/lib/jvm/java-11",
                    default = true,
                  },
                  {
                    name = "JavaSE-17",
                    path = os.getenv("JAVA_HOME_17") or "/usr/lib/jvm/java-17",
                  },
                },
              },
              format = {
                enabled = true,
                settings = {
                  url = os.getenv("JAVA_FORMAT_SETTINGS_URL"),
                  profile = os.getenv("JAVA_FORMAT_SETTINGS_PROFILE"),
                },
              },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
              gofumpt = true,
            },
          },
        },
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
