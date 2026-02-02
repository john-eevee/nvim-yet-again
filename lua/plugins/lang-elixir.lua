-- Add Elixir language support
return {
  -- Add Elixir treesitter parser and grammar
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add elixir to ensure_installed
      vim.list_extend(opts.ensure_installed, {
        "elixir",
        "eex",
      })
    end,
  },

  -- Configure ElixirLS language server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        elixirls = {
          cmd = { "elixir-ls" },
          -- Enable experimental Features like improved hover information
          settings = {
            elixirLS = {
              dialyzerEnabled = true,
              fetchDeps = false,
              enableTestLenses = true,
              suggestSpecs = true,
            },
          },
        },
      },
    },
  },

  -- Add Mason integration for automatic installation
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "elixir-ls",
        "elixirformat",
      },
    },
  },

  -- Optional: Configure nvim-dap for debugging (if dap is used)
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mason.nvim",
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dap.adapters.elixir = {
          type = "executable",
          command = "elixir-ls",
          args = { "--debugger" },
        }

        dap.configurations.elixir = {
          {
            type = "elixir",
            name = "Elixir",
            request = "launch",
            task = "phx.server",
            taskArgs = {},
            startBranch = "main",
          },
        }
      end,
    },
  },
}
