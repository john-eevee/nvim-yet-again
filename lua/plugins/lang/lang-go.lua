-- Add Go language support
return {
  -- Add Go treesitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "go",
        "gomod",
        "gosum",
      })
    end,
  },

  -- Add Mason integration for Go tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        -- LSP
        "gopls",
        -- Formatting
        "goimports",
        "golines",
        -- Linting
        "golangci-lint",
        -- Debugging
        "delve",
      })
    end,
  },
}
