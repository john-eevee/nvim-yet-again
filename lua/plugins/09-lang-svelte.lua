-- Svelte support: treesitter parser + LSP
return {
  -- Treesitter parser for Svelte
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { parsers = { "svelte" } },
  },

  -- Svelte LSP server
  -- mason-lspconfig installs svelte-language-server from this entry, and
  -- lspconfig's built-in config already prefers a project-local binary, so no
  -- custom cmd is needed here.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svelte = {},
      },
    },
  },
}
