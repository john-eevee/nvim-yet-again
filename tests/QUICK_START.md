# Quick Test Reference

## Run All Tests

```bash
cd ~/.config/nvim
tests/run_tests.sh
```

Expected output: **69 tests, 0 failures ✓**

## Individual Test Runs

### Shell Tests (File Structure, Tools, Syntax)
```bash
bash tests/run_tests.sh
```
- 69 comprehensive validations
- Checks: files, directories, Lua syntax, required/optional tools, configuration

### Lua Tests in Neovim

**Module Loading Test**
```bash
nvim -u ~/.config/nvim/init.lua -c "lua require('tests.test_modules')" +q
```
Tests that all configuration modules load without errors.

**Java Configuration Test**
```bash
nvim -u ~/.config/nvim/init.lua -c "lua require('tests.test_java')" +q
```
Validates jdtls, Spotless formatter, Maven/Gradle detection.

**System Integration Test**
```bash
nvim -u ~/.config/nvim/init.lua -c "lua require('tests.test_system')" +q
```
Checks clipboard utilities, Fish shell integration, required system tools.

**Version Compatibility Test**
```bash
nvim -u ~/.config/nvim/init.lua -c "lua require('tests.test_version')" +q
```
Validates Neovim ≥0.9, modern APIs, no deprecated code.

## Test Categories

| Category | What It Tests |
|----------|---------------|
| **Structure** | All required files exist, directory layout correct |
| **Syntax** | No Lua syntax errors in any config files |
| **Tools** | Required: git, fish, curl / Optional: java, mvn, gradle, etc. |
| **Configuration** | lazy.nvim, keymaps, commands, Java setup correctness |
| **Integration** | Clipboard tools, Fish shell wrappers, Git integration |
| **Documentation** | README.md and JAVA_SETUP.md present |
| **Version Compat** | Neovim ≥0.9, modern APIs, no breaking changes |

## Test Results Interpretation

```
✓ Passed - Feature working correctly
✗ Failed - Critical issue, fix required
⚠ Warning - Optional feature missing, non-critical
```

## Common Failures & Fixes

### "Missing: git" / "Missing: fish" / "Missing: curl"
These are required. Install:
```bash
sudo apt install git fish curl  # Linux
brew install git fish curl       # macOS
```

### "No clipboard utility found"
Install at least one:
```bash
sudo apt install wl-clipboard    # Wayland (wl-copy)
sudo apt install xclip           # X11
```

### "Syntax error in: java.lua"
Fix the Lua syntax error:
```bash
luac -p lua/plugins/java.lua
```

### "Neovim version is too old"
Upgrade to Neovim 0.9+:
```bash
brew upgrade neovim     # macOS
nvim --version          # Check version
```

## Integration with Git Workflow

### Add Pre-commit Hook
```bash
#!/bin/bash
bash tests/run_tests.sh || exit 1
```
Save as `.git/hooks/pre-commit` and `chmod +x`.

### Add to CI/CD (GitHub Actions)
```yaml
- run: sudo apt-get install -y neovim git fish curl
- run: bash tests/run_tests.sh
```

## Test Coverage Summary

✅ **Currently Testing:**
- 69 validations across 6 test categories
- File structure (init.lua, lua/**, docs/**)
- Lua syntax on all 15+ config files
- Required system tools (git, fish, curl)
- Optional language tools (Java, Python, Go, Rust, etc.)
- Clipboard utilities for 3 platforms
- Java-specific setup (jdtls, Spotless, Maven/Gradle)
- System integration (clipboard, Git, Fish shell)
- Version compatibility (Neovim ≥0.9)
- Configuration integrity (lazy.nvim, keymaps, commands)

## Performance

Tests complete in ~5-15 seconds depending on system:
- File checks: ~2s
- Syntax validation: ~2s
- Tool availability: ~1-3s (slower if network involved)
- Configuration checks: ~1s

## Manual Verification

When tests pass but something still seems wrong:

```bash
# Check Neovim startup
nvim +checkhealth

# Load config directly
nvim -c "lua print('Config loaded')" +q

# Test module individually
nvim -c "lua require('lua.config.lazy')" +q

# Check for error messages
nvim 2>&1 | head -50
```

## Test File Locations

```
~/.config/nvim/
├── tests/
│   ├── run_tests.sh           # Main shell test runner (69 tests)
│   ├── test_modules.lua       # Module loading validation
│   ├── test_java.lua          # Java setup validation
│   ├── test_system.lua        # System integration validation
│   ├── test_version.lua       # Version compatibility validation
│   └── README.md              # Detailed testing guide
├── lua/lsp/java.lua           # (tested by test_java.lua)
├── lua/plugins/java.lua       # (tested by test_java.lua)
└── init.lua                   # Entry point (tested by all)
```

## When to Run Tests

- ✅ After `git pull` - ensure no breaking changes
- ✅ After `nvim --upgrade` - check compatibility
- ✅ After adding plugins - verify loading
- ✅ After system updates - validate tool availability
- ✅ Before committing - in CI/CD pipeline
- ✅ During troubleshooting - identify exact issues
- ✅ Weekly maintenance - proactive health check

## Test Success Example

```
╔══════════════════════════════════════════════════════════════╗
║       NEOVIM CONFIGURATION VALIDATION TEST SUITE              ║
╚══════════════════════════════════════════════════════════════╝

✓ FILE STRUCTURE: 6/6 required files found
✓ DIRECTORIES: All expected folders present
✓ LUA SYNTAX: 15 files validated, no errors
✓ REQUIRED TOOLS: git, fish, curl all available
✓ OPTIONAL TOOLS: java, mvn, gradle detected
✓ CLIPBOARD: wl-copy available (Wayland)
✓ INIT.LUA: All requires present
✓ LAZY.CONFIG: Plugin specs valid
✓ JAVA SETUP: jdtls, Spotless, wrappers configured
✓ KEYMAPS: Definitions found
✓ COMMANDS: Custom commands present
✓ DOCS: README.md and JAVA_SETUP.md present
✓ GIT: 12 commits, working tree clean

TEST SUMMARY
Total: 69 | Passed: 69 | Failed: 0

✓ All critical tests passed!
```
