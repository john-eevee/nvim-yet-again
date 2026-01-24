-- ╔══════════════════════════════════════════════════════════════╗
-- ║         LSP SETUP - MODERN vim.lsp.config API                 ║
-- ║    Language Server Protocol configuration using Nvim 0.11+    ║
-- ╚══════════════════════════════════════════════════════════════╝

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- CAPABILITIES SETUP
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Enable nvim-cmp capabilities
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp then
  capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
end

-- Enable snippet support
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- GLOBAL CONFIGURATION - APPLIES TO ALL SERVERS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git", "root" },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LUA - lua_ls (Lua Language Server)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      format = {
        enable = false, -- Use stylua via conform.nvim
      },
    },
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- PYTHON - pyright
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.lsp.config("pyright", {
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TYPESCRIPT/JAVASCRIPT - ts_ls (TypeScript Language Server)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.lsp.config("ts_ls", {
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- WEB - HTML, CSS, JSON, YAML
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.lsp.config("html", {
  filetypes = { "html", "htm" },
})

vim.lsp.config("cssls", {
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    scss = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    less = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})

vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas = (function()
        local has_schemastore, schemastore = pcall(require, "schemastore")
        if has_schemastore then
          return schemastore.json.schemas()
        end
        return {}
      end)(),
      validate = { enable = true },
    },
  },
})

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = (function()
        local has_schemastore, schemastore = pcall(require, "schemastore")
        if has_schemastore then
          return schemastore.yaml.schemas()
        end
        return {}
      end)(),
    },
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- ESLINT - JavaScript/TypeScript linting
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.lsp.config("eslint", {
  root_markers = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "package.json",
  },
  settings = {
    workingDirectory = { mode = "auto" },
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- JAVA - jdtls (Eclipse JDT Language Server)
-- Note: jdtls requires special setup, handled via ftplugin/java.lua
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Java is handled by nvim-jdtls plugin via ftplugin/java.lua
-- This ensures proper workspace and project configuration

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- ELIXIR - elixirls (Elixir Language Server)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.lsp.config("elixirls", {
  cmd = { "elixir-ls" },
  root_markers = { "mix.exs", ".git" },
  settings = {
    elixirLS = {
      dialyzerEnabled = true,
      fetchDeps = false,
      suggestSpecs = true,
    },
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- DART/FLUTTER - dartls (Dart Language Server)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.lsp.config("dartls", {
  cmd = { "dart", "language-server", "--protocol=lsp" },
  root_markers = { "pubspec.yaml", ".git" },
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = false,
    suggestFromUnimportedLibraries = true,
    closingLabels = true,
    outline = true,
    flutterOutline = true,
  },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
      enableSnippets = true,
      lineLength = 120,
    },
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MARKDOWN - marksman
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.lsp.config("marksman", {
  filetypes = { "markdown", "markdown.mdx" },
})



-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LSP ATTACH CONFIGURATION
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    local bufnr = ev.buf
    local keymap = vim.keymap.set
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- NAVIGATION KEYMAPS
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    keymap("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "LSP: Go to declaration" }))
    keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP: Go to definition" }))
    keymap("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "LSP: Go to implementation" }))
    keymap("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "LSP: Go to type definition" }))

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- DOCUMENTATION & HOVER
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    -- K is already mapped by default, but we add it explicitly for clarity
    keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: Hover documentation" }))
    keymap("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "LSP: Signature help" }))
    keymap("i", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "LSP: Signature help" }))

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- WORKSPACE MANAGEMENT
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
      vim.tbl_extend("force", opts, { desc = "LSP: Add workspace folder" }))
    keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
      vim.tbl_extend("force", opts, { desc = "LSP: Remove workspace folder" }))
    keymap("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, vim.tbl_extend("force", opts, { desc = "LSP: List workspace folders" }))

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- CODE ACTIONS & REFACTORING
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
      vim.tbl_extend("force", opts, { desc = "LSP: Code action" }))
    keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP: Rename symbol" }))

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- REFERENCES & SEARCH
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    keymap("n", "<leader>lr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "LSP: References" }))
    keymap("n", "<leader>ls", vim.lsp.buf.document_symbol,
      vim.tbl_extend("force", opts, { desc = "LSP: Document symbols" }))
    keymap("n", "<leader>lw", vim.lsp.buf.workspace_symbol,
      vim.tbl_extend("force", opts, { desc = "LSP: Workspace symbols" }))

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- FORMATTING
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    if client:supports_method("textDocument/formatting") then
      keymap("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, vim.tbl_extend("force", opts, { desc = "LSP: Format buffer" }))

      -- Auto-format on save (optional - can be disabled)
      -- Uncomment the following to enable auto-format on save:
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = false }),
      --   buffer = bufnr,
      --   callback = function()
      --     vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 2000 })
      --   end,
      -- })
    end

    if client:supports_method("textDocument/rangeFormatting") then
      keymap("v", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, vim.tbl_extend("force", opts, { desc = "LSP: Format selection" }))
    end

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- DIAGNOSTICS
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    keymap("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Diagnostic: Previous" }))
    keymap("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Diagnostic: Next" }))
    keymap("n", "<leader>ld", vim.diagnostic.open_float,
      vim.tbl_extend("force", opts, { desc = "Diagnostic: Line diagnostics" }))
    keymap("n", "<leader>lq", vim.diagnostic.setloclist,
      vim.tbl_extend("force", opts, { desc = "Diagnostic: Set loclist" }))

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- CODELENS
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    if client:supports_method("textDocument/codeLens") then
      keymap("n", "<leader>cl", vim.lsp.codelens.run, vim.tbl_extend("force", opts, { desc = "LSP: Run codelens" }))
      keymap("n", "<leader>cL", vim.lsp.codelens.refresh,
        vim.tbl_extend("force", opts, { desc = "LSP: Refresh codelens" }))

      -- Auto-refresh codelens
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = bufnr,
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = bufnr })
        end,
      })
    end

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- INLAY HINTS (if supported)
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    if client:supports_method("textDocument/inlayHint") then
      keymap("n", "<leader>lh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end, vim.tbl_extend("force", opts, { desc = "LSP: Toggle inlay hints" }))
    end

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- DOCUMENT HIGHLIGHTING
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    if client:supports_method("textDocument/documentHighlight") then
      local highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        group = highlight_group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = bufnr,
        group = highlight_group,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- TELESCOPE INTEGRATION (if available)
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    local has_telescope, telescope_builtin = pcall(require, "telescope.builtin")
    if has_telescope then
      keymap("n", "<leader>lR", telescope_builtin.lsp_references,
        vim.tbl_extend("force", opts, { desc = "LSP: References (Telescope)" }))
      keymap("n", "<leader>lS", telescope_builtin.lsp_document_symbols,
        vim.tbl_extend("force", opts, { desc = "LSP: Document symbols (Telescope)" }))
      keymap("n", "<leader>lW", telescope_builtin.lsp_workspace_symbols,
        vim.tbl_extend("force", opts, { desc = "LSP: Workspace symbols (Telescope)" }))
      keymap("n", "<leader>li", telescope_builtin.lsp_implementations,
        vim.tbl_extend("force", opts, { desc = "LSP: Implementations (Telescope)" }))
      keymap("n", "<leader>lt", telescope_builtin.lsp_type_definitions,
        vim.tbl_extend("force", opts, { desc = "LSP: Type definitions (Telescope)" }))
    end

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- LSP INFO
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    keymap("n", "<leader>li", "<cmd>LspInfo<CR>", vim.tbl_extend("force", opts, { desc = "LSP: Info" }))
    keymap("n", "<leader>lI", function()
      print(string.format("LSP: %s (ID: %d)", client.name, client.id))
    end, vim.tbl_extend("force", opts, { desc = "LSP: Client info" }))

    -- Notify that LSP has attached
    vim.notify(
      string.format("LSP '%s' attached to buffer %d", client.name, bufnr),
      vim.log.levels.INFO,
      { title = "LSP" }
    )
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- DIAGNOSTIC CONFIGURATION
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "if_many",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Define diagnostic signs
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn",  text = "" },
  { name = "DiagnosticSignHint",  text = "" },
  { name = "DiagnosticSignInfo",  text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LSP HANDLERS CUSTOMIZATION
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Customize hover handler
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- Customize signature help handler
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- ENABLE LSP SERVERS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Enable all configured servers
local servers = {
  "lua_ls",
  "pyright",
  "ts_ls",
  "html",
  "cssls",
  "jsonls",
  "yamlls",
  "eslint",
  "elixirls",
  "dartls",
  "marksman",
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-- Note: Java (jdtls) is handled separately via ftplugin/java.lua
-- due to its complex workspace requirements
