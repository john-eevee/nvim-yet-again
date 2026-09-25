return {
  -- Treesitter parser for Rust
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { parsers = { "rust" } },
  },

  -- Rust LSP (rust-analyzer is resolved from $PATH: mason's binary comes first
  -- and works; `mise x -- rust-analyzer` loops through the rustup/mise shims)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true, loadOutDirsFromCheck = true, runBuildScripts = true },
              checkOnSave = { command = "clippy", extraArgs = { "--all-targets", "--all-features" } },
              procMacro = { enable = true },
            },
          },
        },
      },
    },
  },

  -- Mason tools for Rust
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "codelldb",
      })
    end,
  },

  -- Cargo.toml editing helpers
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function()
      require("crates").setup()
    end,
  },
}
