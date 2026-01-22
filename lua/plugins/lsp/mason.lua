-- ╔══════════════════════════════════════════════════════════════╗
-- ║         MASON - LSP SERVER INSTALLER & MANAGER                ║
-- ║    Auto-install language servers and tools                    ║
-- ╚══════════════════════════════════════════════════════════════╝

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

mason_lspconfig.setup({
  ensure_installed = {
    -- Core languages
    "lua_ls",
    "pyright",

    -- Web development (Node.js, TypeScript, JavaScript)
    "ts_ls",
    "html",
    "cssls",
    "jsonls",
    "yamlls",
    "eslint",

    -- Java development
    "jdtls",

    -- Elixir development
    "elixirls",

    -- Dart/Flutter development
    -- "dartls", there is no dartls in mason

    -- Documentation
    "marksman",
  },
  automatic_installation = true,
})
