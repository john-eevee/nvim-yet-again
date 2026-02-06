-- Add Rust language support
return {
  -- Add Rust treesitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "rust",
        "toml",
      })
    end,
  },

  -- Configure Rust Analyzer (LSP)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
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
      },
    },
  },

  -- Add Mason integration for Rust tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "rust-analyzer",
        "rustfmt",
        "codelldb",
      })
    end,
  },

  -- Conform configuration for Rust formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt" },
      },
    },
  },

  -- nvim-dap configuration for Rust debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mason.nvim",
    },
    config = function(_, opts)
      local dap = require("dap")
      if not dap.adapters.codelldb then
        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = "codelldb",
            args = { "--port", "${port}" },
          },
        }
      end
      if not dap.configurations.rust then
        dap.configurations.rust = {
          {
            type = "codelldb",
            name = "Debug",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
          },
          {
            type = "codelldb",
            name = "Debug (with input)",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = function()
              local input = vim.fn.input("Arguments: ")
              return vim.split(input, " ")
            end,
          },
        }
      end
    end,
  },

  -- rust-tools for enhanced Rust support
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local rt = require("rust-tools")

      rt.setup({
        tools = {
          autoSetHints = true,
          hover_with_actions = true,
          inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          runnables = {
            use_telescope = true,
          },
        },
        server = {
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
            },
          },
        },
      })

      -- Keymaps for Rust tools
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      map(
        "n",
        "<leader>Rh",
        rt.hover_actions.hover_actions,
        vim.tbl_extend("force", opts, { desc = "Rust: Hover actions" })
      )
      map(
        "n",
        "<leader>Ra",
        rt.code_action_group.code_action_group,
        vim.tbl_extend("force", opts, { desc = "Rust: Code actions" })
      )
      map("n", "<leader>Rd", rt.debuggables.debuggables, vim.tbl_extend("force", opts, { desc = "Rust: Debuggables" }))
      map("n", "<leader>Rr", rt.runnables.runnables, vim.tbl_extend("force", opts, { desc = "Rust: Runnables" }))
      map(
        "n",
        "<leader>Rp",
        rt.parent_module.parent_module,
        vim.tbl_extend("force", opts, { desc = "Rust: Parent module" })
      )
      map("n", "<leader>Rj", function()
        rt.join_lines.join_lines()
      end, vim.tbl_extend("force", opts, { desc = "Rust: Join lines" }))
      map(
        "n",
        "<leader>Re",
        rt.expand_macro.expand_macro,
        vim.tbl_extend("force", opts, { desc = "Rust: Expand macro" })
      )
      map("n", "<leader>RS", rt.ssr.ssr, vim.tbl_extend("force", opts, { desc = "Rust: Structural search replace" }))
    end,
  },

  -- Cargo for Rust builds
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function()
      require("crates").setup()
    end,
  },
}
