-- Add Rust language support
return {
  -- Add Rust treesitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "rust",
        "toml",
      })
    end,
  },

  -- Add Mason integration for Rust tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        -- LSP
        "rust-analyzer",
        -- Formatting
        "rustfmt",
        -- Debugging
        "codelldb",
      })
    end,
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
