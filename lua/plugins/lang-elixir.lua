-- Add Elixir language support
return {
  -- Add Elixir treesitter parser and grammar
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add elixir to ensure_installed
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "elixir",
        "eex",
      })
    end,
  },

  -- Add Mason integration for automatic installation
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "elixir-ls",
      })
    end,
  },
}
