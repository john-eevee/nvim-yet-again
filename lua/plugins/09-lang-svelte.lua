-- Svelte support: LSP (svelte-language-server via mise/npx)
return {
  -- Svelte LSP server
  -- mason-lspconfig bridge auto-installs svelte-language-server from this entry
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svelte = {
          cmd = { "mise", "x", "--", "npx", "svelte-language-server", "--stdio" },
        },
      },
    },
  },
}
