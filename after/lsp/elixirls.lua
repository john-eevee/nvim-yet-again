-- Elixir LSP Configuration (ElixirLS)
-- Language server for Elixir providing diagnostics and code intelligence

return {
  cmd = { 'elixir-ls' },
  settings = {
    elixirLS = {
      dialyzerEnabled = true,
      fetchDeps = false,
      enableTestLenses = true,
      suggestSpecs = true,
    },
  },
}
