return {
  -- Rust LSP via mise (uses project-specific rust-analyzer version)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          cmd = _G.mise_cmd("rust-analyzer"),
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
