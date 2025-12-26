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
    -- Web development
    "ts_ls",
    "html",
    "cssls",
    "jsonls",
    "yamlls",

    -- Java development
    "jdtls",

    -- Documentation
    "marksman",

    -- Additional tools
    "eslint",
  },
  automatic_installation = true,
})
