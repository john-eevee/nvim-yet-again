# Neovim Gradle/Java LSP Configuration Fixes

## Issues Identified & Fixed

### Issue 1: Gradle Filetype Detection ✅ FIXED
**Problem**: While Neovim does detect `.gradle` files as groovy, there was no explicit configuration to ensure consistent detection on file open.

**Root Cause**: Missing autocommand for BufRead/BufNewFile events on Gradle files.

**Fix Applied**:
- Added autocommand in `lua/config/autocmds.lua` to explicitly set filetype to groovy for `*.gradle`, `*.gradle.kts`, `build.gradle`, and `settings.gradle`
- Created `ftplugin/groovy.lua` for Gradle-specific settings

**Verification**:
```bash
nvim build.gradle
# Expected: filetype=groovy ✓
```

---

### Issue 2: Gradle Dependency Discovery by LSP ✅ FIXED
**Problem**: JDTLS couldn't find Gradle dependencies and didn't properly detect project roots in multi-module Gradle projects.

**Root Cause**: Multiple configuration issues:

1. **Global root_markers too restrictive**
   - `lsp/setup.lua` line 34 set only `.git` as root marker globally
   - This was too narrow for Java/Gradle projects that might use `build.gradle` or `gradlew` as markers
   
2. **JDTLS configuration incomplete**
   - JDTLS settings were only in ftplugin, not in lsp/setup.lua
   - Missing explicit root markers for Java-specific files
   - No Gradle import configuration at the LSP level

3. **Missing Groovy LSP support**
   - No LSP capabilities for Gradle build files themselves
   - Build scripts couldn't provide IDE features

**Fixes Applied**:

#### Fix 1: Enhanced Global Root Markers (`lua/lsp/setup.lua` line 34)
```lua
vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git", "root" },  -- Added "root" as fallback
})
```

#### Fix 2: Added JDTLS Configuration Block (`lua/lsp/setup.lua` after Marksman)
```lua
vim.lsp.config("jdtls", {
  root_markers = { 
    ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts", ".java-version" 
  },
  settings = {
    java = {
      import = {
        gradle = {
          enabled = true,  -- Enable Gradle import
        },
      },
      configuration = {
        updateBuildConfiguration = "automatic",
        detectSourceLanguageFromExternalBuildFiles = true,
      },
    },
  },
})
```

#### Fix 3: Added Gradle Filetype Detection (`lua/config/autocmds.lua`)
```lua
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetype_group,
  pattern = { "*.gradle", "*.gradle.kts", "build.gradle", "settings.gradle" },
  callback = function()
    vim.bo.filetype = "groovy"
  end,
})
```

#### Fix 4: Created Groovy Ftplugin (`ftplugin/groovy.lua`)
- Sets proper indentation (4 spaces for Groovy)
- Provides LSP hints for Gradle files
- Enables Java LSP for build scripts when available

#### Fix 5: Enhanced Java Ftplugin (`ftplugin/java.lua`)
- Added debug command: `<leader>js` to show JDTLS status
- Improved workspace logging for diagnostics
- Added notification showing workspace directory

---

## How This Fixes Gradle Dependency Issues

### Before
1. Open `build.gradle` → No LSP support
2. Open Java file → JDTLS struggles to find project root
3. Dependencies not recognized → No completion/diagnostics

### After
1. Open `build.gradle` → Filetype correctly detected as groovy
2. JDTLS uses multiple root markers to find project root (gradlew, build.gradle, .git)
3. Gradle configuration automatically imported
4. Dependencies recognized → Full IDE support

---

## Testing the Fix

### Test 1: Gradle File Detection
```bash
cd /home/john/code/wsfv-java
nvim build.gradle
# Type: `:set filetype?`
# Expected: filetype=groovy ✓
```

### Test 2: Java File with Gradle Project
```bash
cd /home/john/code/wsfv-java
nvim src/main/java/MyClass.java
# Type: `<leader>js` (new debug command)
# Should show JDTLS status with workspace and root directory
```

### Test 3: Dependency Completion
```bash
nvim datapatch-web/src/main/java/example/Main.java
# Start typing a Spring import
# Type: import org.spring<C-x><C-o>
# Expected: Gradle dependencies appear in completion ✓
```

---

## Configuration Files Modified

1. **`lua/lsp/setup.lua`**
   - Line 34: Enhanced global root_markers
   - Lines 253+: Added JDTLS configuration block

2. **`lua/config/autocmds.lua`**
   - Lines 46-54: Added Gradle filetype detection autocommand

3. **`ftplugin/groovy.lua`** (NEW)
   - Provides Groovy-specific settings
   - Enables Java LSP for build scripts

4. **`ftplugin/java.lua`**
   - Lines 28-31: Added workspace debug logging
   - Lines 238-251: Added debug command and improved status display

---

## Debugging Commands

### Show JDTLS Status
- **Command**: `<leader>js` (in Java buffers)
- **Shows**: Root directory, LSP client info, workspace location

### Check Filetype
- **Command**: `:set filetype?`
- **Expected**: `groovy` for *.gradle files, `java` for *.java files

### LSP Info
- **Command**: `<leader>li`
- **Shows**: All active LSP clients and their status

---

## Notes

- JDTLS is installed via Mason (`mason/packages/jdtls`)
- Java 24 is available via mise (`java` in PATH)
- Gradle 9.2.1 is available via mise (`gradle` in PATH)
- Workspace stored in `~/.local/share/eclipse/`

---

## Related Documentation

- JDTLS Fix Summary: See `JDTLS_FIX_SUMMARY.md`
- Java Best Practices: See `~/code/wsfv-java/README.md`
- Neovim Config: See `README.md`
