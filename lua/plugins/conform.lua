require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters_by_ft = {
    lua = { "stylua" },
    java = { "spotless_maven", "spotless_gradle", stop_after_first = true },
    elixir = { "mix"},
    python = { "black", "isort" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    ["typescriptreact"] = { "prettierd" },
    json = { "prettierd" },
    markdown = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
    yaml = { "prettierd" },
  },
})
