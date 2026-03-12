-- Add Python language support with Ty, Ruff, and Uv (Astral Stack)
-- See: https://docs.astral.sh/ty/editors/
return {
  -- Add Python treesitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "python",
      })
    end,
  },

  -- Add Mason integration for Python tools (Astral stack)
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        -- LSP
        "pyright",
        -- Type checking with Ty
        "ty",
        -- Linting and formatting with Ruff (replaces flake8, black, isort, etc.)
        "ruff",
        -- Debugging
        "debugpy",
      })
    end,
  },
}
