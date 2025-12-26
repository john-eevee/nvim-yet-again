-- ╔══════════════════════════════════════════════════════════════╗
-- ║           LSP SETUP - LANGUAGE SERVER CONFIGURATION            ║
-- ║     Configure LSP servers with diagnostics and handlers        ║
-- ╚══════════════════════════════════════════════════════════════╝

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- DIAGNOSTICS SETUP
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    format = function(diag)
      return string.format("%s (%s: %s)", diag.message, diag.source, diag.code or "E")
    end,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Set diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LSP CAPABILITIES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.offsetEncoding = { "utf-16" }

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LSP ATTACH CALLBACK
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.keymap.set

  -- Keymaps
  keymap("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Goto definition" })
  keymap("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: Goto declaration" })
  keymap("n", "gI", vim.lsp.buf.implementation, { desc = "LSP: Goto implementation" })
  keymap("n", "gr", vim.lsp.buf.references, { desc = "LSP: References" })
  keymap("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover" })
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature help" })
  keymap("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP: Code actions" })
  keymap("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP: Rename" })
  keymap("n", "<leader>ld", vim.diagnostic.open_float, { desc = "LSP: Line diagnostic" })
  keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Prev diagnostic" })
  keymap("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Next diagnostic" })
  keymap("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, { desc = "LSP: Format buffer" })

  -- Telescope integration
  local builtin = require("telescope.builtin")
  keymap("n", "<leader>ld", builtin.diagnostics, { desc = "LSP: Diagnostics" })
  keymap("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "LSP: Document symbols" })
  keymap("n", "<leader>lS", builtin.lsp_workspace_symbols, { desc = "LSP: Workspace symbols" })
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SERVER CONFIGURATIONS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Lua LS (neovim)
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- Python
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
        typeCheckingMode = "standard",
      },
    },
  },
})

-- Rust
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

-- Go
lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      usePlaceholders = true,
      completeUnimported = true,
    },
  },
})

-- C/C++
lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- TypeScript
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    preferences = {
      disableSuggestions = false,
    },
  },
})

-- HTML
lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- CSS
lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- JSON
lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- YAML
lspconfig.yamlls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Markdown
lspconfig.marksman.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- AUTO SETUP REMAINING SERVERS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
})
