-- Elixir support: treesitter parsers (LSP is configured via vim.lsp in init.lua)
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { parsers = { "elixir", "heex", "eex", "typespec" } },
  },
}
