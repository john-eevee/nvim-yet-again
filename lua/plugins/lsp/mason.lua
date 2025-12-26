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
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "gopls",
    "clangd",
    "ts_ls",
    "html",
    "cssls",
    "jsonls",
    "yamlls",
    "marksman",
  },
  automatic_installation = true,
})
