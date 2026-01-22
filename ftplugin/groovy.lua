-- ╔══════════════════════════════════════════════════════════════╗
-- ║      GROOVY FTPLUGIN - Build script support               ║
-- ║   Enables Java LSP for Gradle/Groovy build files          ║
-- ╚══════════════════════════════════════════════════════════════╝

-- Prevent multiple invocations
if vim.b.did_ftplugin_groovy then
  return
end
vim.b.did_ftplugin_groovy = true

-- Set indentation for Groovy
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

-- Enable Java LSP for build.gradle and similar files
-- This allows JDTLS to provide IDE features in build scripts
local current_file = vim.fn.expand("%:t")
if current_file:match("^build%.gradle") or current_file:match("^settings%.gradle") or current_file:match("^gradle%.properties") then
  -- Try to attach Java LSP if available
  local jdtls_ok, jdtls = pcall(require, "jdtls")
  if jdtls_ok then
    -- Find the root of the Java/Gradle project
    local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
    
    if root_dir then
      vim.notify("Java LSP available for Gradle file: " .. current_file, vim.log.levels.INFO, { title = "Groovy LSP" })
    end
  else
    vim.notify("nvim-jdtls not found - IDE features unavailable for " .. current_file, vim.log.levels.WARN, { title = "Groovy LSP" })
  end
end

-- Set commentstring for Groovy
vim.opt_local.commentstring = "// %s"
