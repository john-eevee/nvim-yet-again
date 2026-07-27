require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

-- Native Nvim 0.11+ Elixir LSP configuration (mise-managed expert)
vim.lsp.config("expert", {
  cmd = { "mise", "x", "--", "expert", "--stdio" },
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  root_markers = { "mix.exs" },
  single_file_support = true,
})
vim.lsp.enable("expert")
