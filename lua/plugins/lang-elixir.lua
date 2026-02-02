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
          -- Enable experimental features like improved hover information
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
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "elixir-ls",
        "elixirformat",
      })
    end,
  },
}
