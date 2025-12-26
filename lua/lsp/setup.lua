-- ╔══════════════════════════════════════════════════════════════╗
-- ║           LSP SETUP - LANGUAGE SERVER CONFIGURATION            ║
-- ║     Configure LSP servers with diagnostics and handlers        ║
-- ╚══════════════════════════════════════════════════════════════╝

local lspconfig = require("lspconfig")
local has_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not has_mason_lspconfig then
  vim.notify("mason-lspconfig not available; automatic server setup will be skipped", vim.log.levels.WARN)
end
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

-- Java (jdtls)
-- Install: :MasonInstall jdtls
-- Note: jdtls requires Java 11+ to run
local java_filetypes = { "java" }
local jdtls_setup_done = false

vim.api.nvim_create_autocmd("FileType", {
  pattern = java_filetypes,
  callback = function()
    if jdtls_setup_done then return end
    jdtls_setup_done = true

    local jdtls = require("jdtls")
    local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
    local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

    if launcher_jar == "" then
      vim.notify("jdtls not found. Run :MasonInstall jdtls", vim.log.levels.WARN)
      return
    end

    local workspace_dir = vim.fn.getcwd()
    local project_name = vim.fn.fnamemodify(workspace_dir, ":p:h:t")
    local workspace = vim.fn.stdpath("data") .. "/jdtls_workspace/" .. project_name

    local config = {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=NONE",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", launcher_jar,
        "-configuration", jdtls_path .. "/config_linux",
        "-data", workspace,
      },
      root_dir = jdtls.setup.find_root({ "gradle.build", "pom.xml", ".git" }),
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = {
        bundles = {},
      },
    }

    jdtls.start_or_attach(config)
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- AUTO SETUP REMAINING SERVERS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Mason 2 removed `setup_handlers`. Use a compatibility approach:
-- 1) If the old `setup_handlers` function exists, use it (backwards compat).
-- 2) Else, iterate installed servers via `mason_lspconfig.get_installed_servers()` and call `lspconfig[server].setup()`.
-- 3) As a last resort, set defaults on `vim.lsp.configs[server]` so that servers pick them up when started.
if has_mason_lspconfig and type(mason_lspconfig.setup_handlers) == "function" then
  mason_lspconfig.setup_handlers({
    function(server_name)
      if lspconfig[server_name] and type(lspconfig[server_name].setup) == "function" then
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      else
        vim.notify("lspconfig handler missing for: " .. server_name, vim.log.levels.WARN)
      end
    end,
  })
elseif has_mason_lspconfig and type(mason_lspconfig.get_installed_servers) == "function" then
  local installed = mason_lspconfig.get_installed_servers()
  for _, server_name in ipairs(installed) do
    if lspconfig[server_name] and type(lspconfig[server_name].setup) == "function" then
      lspconfig[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    else
      -- Fallback: set defaults on vim.lsp.configs to ensure handlers/capabilities are present
      if vim.lsp and vim.lsp.configs and vim.lsp.configs[server_name] then
        vim.lsp.configs[server_name].default_config = vim.tbl_extend("force", vim.lsp.configs[server_name].default_config or {}, {
          capabilities = capabilities,
          on_attach = on_attach,
        })
      else
        vim.notify("Cannot automatically configure LSP server: " .. server_name, vim.log.levels.WARN)
      end
    end
  end
else
  -- mason-lspconfig not available or no compatible API; do not attempt auto-setup
  vim.notify("mason-lspconfig setup_handlers/get_installed_servers unavailable; automatic server setup skipped", vim.log.levels.WARN)
end
