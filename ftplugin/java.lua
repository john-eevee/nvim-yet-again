-- ╔══════════════════════════════════════════════════════════════╗
-- ║         JAVA FTPLUGIN - JDTLS CONFIGURATION                   ║
-- ║    Java Language Server setup with nvim-jdtls                 ║
-- ╚══════════════════════════════════════════════════════════════╝

-- Only run once per buffer
if vim.b.did_ftplugin_java then
  return
end
vim.b.did_ftplugin_java = true

-- Check if jdtls is available
local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.api.nvim_echo({
    { "nvim-jdtls not found, Java LSP not configured", "WarningMsg" }
  }, false, {})
  return
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- PATHS AND DIRECTORIES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local home = os.getenv("HOME")
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local workspace_dir = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- Ensure workspace directory exists
vim.fn.mkdir(workspace_dir, "p")

-- Debug: Log workspace initialization (silent, no message)
-- Uncomment to print: print("JDTLS Workspace: " .. workspace_dir .. "\nJDTLS Path: " .. jdtls_path)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- CAPABILITIES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Enable nvim-cmp capabilities
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp then
  capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- JDTLS EXTENDED CLIENT CAPABILITIES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- BUNDLES FOR DEBUGGING AND TESTING
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local bundles = {}

-- Java Debug Adapter
local java_debug_path = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter"
local java_debug_jar = vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
if java_debug_jar ~= "" then
  table.insert(bundles, java_debug_jar)
end

-- Java Test Runner
local java_test_path = vim.fn.stdpath("data") .. "/mason/packages/java-test"
local java_test_jars = vim.fn.glob(java_test_path .. "/extension/server/*.jar", true)
if java_test_jars ~= "" then
  for _, jar in ipairs(vim.split(java_test_jars, "\n")) do
    if jar ~= "" then
      table.insert(bundles, jar)
    end
  end
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- JDTLS CONFIGURATION
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", jdtls_path .. "/config_" .. (vim.fn.has("mac") == 1 and "mac" or "linux"),
    "-data", workspace_dir,
  },

  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

  capabilities = capabilities,

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      import = {
        gradle = {
          enabled = true,
        },
      },
      configuration = {
        updateBuildConfiguration = "automatic",
        detectSourceLanguageFromExternalBuildFiles = true,
        runtimes = {
          -- Add your Java runtimes here, for example:
          -- {
          --   name = "JavaSE-11",
          --   path = "/usr/lib/jvm/java-11-openjdk/",
          -- },
          -- {
          --   name = "JavaSE-17",
          --   path = "/usr/lib/jvm/java-17-openjdk/",
          -- },
        },
      },
      project = {
        sourceLanguage = "11",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities,
  },
}

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- JAVA-SPECIFIC KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

config.on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  local keymap = vim.keymap.set

  -- Standard LSP mappings are handled by LspAttach autocmd in lsp/setup.lua

  -- Java-specific commands
  keymap("n", "<leader>jo", "<Cmd>lua require'jdtls'.organize_imports()<CR>",
    vim.tbl_extend("force", opts, { desc = "Java: Organize imports" }))
  keymap("n", "<leader>jv", "<Cmd>lua require'jdtls'.extract_variable()<CR>",
    vim.tbl_extend("force", opts, { desc = "Java: Extract variable" }))
  keymap("v", "<leader>jv", "<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>",
    vim.tbl_extend("force", opts, { desc = "Java: Extract variable" }))
  keymap("n", "<leader>jc", "<Cmd>lua require'jdtls'.extract_constant()<CR>",
    vim.tbl_extend("force", opts, { desc = "Java: Extract constant" }))
  keymap("v", "<leader>jc", "<Esc><Cmd>lua require'jdtls'.extract_constant(true)<CR>",
    vim.tbl_extend("force", opts, { desc = "Java: Extract constant" }))
  keymap("v", "<leader>jm", "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>",
    vim.tbl_extend("force", opts, { desc = "Java: Extract method" }))

  -- Testing
  keymap("n", "<leader>jt", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>",
    vim.tbl_extend("force", opts, { desc = "Java: Test nearest method" }))
  keymap("n", "<leader>jT", "<Cmd>lua require'jdtls'.test_class()<CR>",
    vim.tbl_extend("force", opts, { desc = "Java: Test class" }))

  -- Debug: Show JDTLS status
  keymap("n", "<leader>js", function()
    local root = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
    local msg = "JDTLS Status: Root: " .. (root or "NOT FOUND") .. " | Client: " .. client.name .. " (ID: " .. client.id .. ")"
    vim.api.nvim_echo({
      { msg, "ModeMsg" }
    }, false, {})
  end, vim.tbl_extend("force", opts, { desc = "Java: Show JDTLS status" }))

  -- Update codelens on save
  vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold" }, {
    buffer = bufnr,
    callback = function()
      vim.lsp.codelens.refresh({ bufnr = bufnr })
    end,
  })

  -- Enable inlay hints if supported
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  vim.api.nvim_echo({
    { "JDTLS attached to buffer " .. bufnr, "ModeMsg" }
  }, false, {})
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- START JDTLS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

jdtls.start_or_attach(config)
