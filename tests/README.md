# Configuration Testing Guide

This directory contains comprehensive tests to validate your Neovim configuration works correctly and remains compatible across version changes.

## Quick Start

Run all tests:

```bash
./tests/run_tests.sh
```

Run specific Lua tests in Neovim:

```bash
# Test module loading
nvim -u NONE -c "source tests/test_modules.lua" -c "q!"

# Test Java configuration
nvim -u NONE -c "source tests/test_java.lua" -c "q!"

# Test system integration
nvim -u NONE -c "source tests/test_system.lua" -c "q!"

# Test version compatibility
nvim -u NONE -c "source tests/test_version.lua" -c "q!"
```

## Test Files

### `run_tests.sh` - Shell-Based Validation

Main test runner that performs:

- **File Structure Tests**
  - Validates all required files exist
  - Checks directory structure
  - Example: `init.lua`, `lua/config/*.lua`, `lua/lsp/java.lua`, `lua/plugins/java.lua`

- **Lua Syntax Validation**
  - Uses `luac` to check Lua syntax in all files
  - Catches syntax errors before they break the config
  - Validates ~15+ Lua files

- **Required Tools**
  - `git` - version control
  - `fish` - shell integration
  - `curl` - for plugins and utilities

- **Optional Tools**
  - `java` - for jdtls LSP
  - `mvn` / `gradle` - for Java projects
  - `node`, `python3`, `rustc`, `go` - for language runtimes
  - `luac` - for syntax checking

- **Clipboard Utilities**
  - At least one of: `wl-copy` (Wayland), `xclip` (X11), `pbcopy` (macOS)
  - Required for clipboard path functionality

- **Configuration Validation**
  - Checks `init.lua` for required requires
  - Validates `lazy.lua` plugin specifications
  - Verifies Java setup correctness
  - Validates keymaps and commands

- **Documentation**
  - Checks for README.md and docs/JAVA_SETUP.md
  - Reports file line counts

- **Git Status**
  - Shows commit count and last commit
  - Reports uncommitted changes

### `test_modules.lua` - Module Loading Test

Validates that all configuration modules can be required without errors:

```lua
require("config.lazy")      -- Plugin manager setup
require("config.options")   -- Neovim options
require("config.keymaps")   -- Keyboard mappings
require("config.commands")  -- Custom commands
require("lsp.java")         -- Java LSP configuration
```

**Checks for:**
- Each module loads successfully
- No circular dependency issues
- No missing imports or typos
- Proper error handling

### `test_java.lua` - Java Configuration Test

Validates Java development setup:

- ✓ `lua/lsp/java.lua` exists
- ✓ `lua/plugins/java.lua` exists
- ✓ jdtls configuration present
- ✓ Maven/Gradle detection implemented
- ✓ Spotless formatter configured
- ✓ Wrapper script detection (mvnw/gradlew)
- ⚠ Java runtime available (optional)

**Use case:** After updating Java plugins or refactoring Java setup

### `test_system.lua` - System Integration Test

Validates system-level integration:

- ✓ Clipboard utility functions in `commands.lua`
- ✓ Fish shell wrapper integration
- ✓ Git commands configured
- ✓ Required system tools available: git, fish, curl
- ✓ At least one clipboard tool available
- ✓ All expected functions and utilities present

**Use case:** When switching machines or after system updates

### `test_version.lua` - Version Compatibility Test

Ensures configuration works with current Neovim version:

- ✓ Neovim >= 0.9
- ✓ Required APIs available
- ✓ Not using deprecated APIs
- ✓ Lua 5.x runtime
- ✓ No breaking changes detected

**Use case:** After Neovim updates, to catch compatibility issues

## Common Issues & Fixes

### Test Failure: "Missing: git"
**Fix:** Install git
```bash
# macOS
brew install git

# Linux (Debian/Ubuntu)
sudo apt install git

# Linux (Fedora)
sudo dnf install git
```

### Test Failure: "Missing: fish"
**Fix:** Install Fish shell
```bash
# macOS
brew install fish

# Linux (Debian/Ubuntu)
sudo apt install fish

# Linux (Fedora)
sudo dnf install fish
```

### Test Failure: "No clipboard utility found"
**Fix:** Install one of the clipboard tools
```bash
# Wayland
sudo apt install wl-clipboard

# X11
sudo apt install xclip

# macOS (pbcopy is built-in)
```

### Test Failure: "Syntax error in: xyz.lua"
**Fix:** Fix the Lua syntax error
```bash
# Check syntax manually
luac -p lua/config/xyz.lua
```

### Test Failure: "Failed to load config.lazy"
**Fix:** Check for circular dependencies or missing plugins.nvim
```bash
nvim
:Mason           # Ensure Mason is installed
:checkhealth     # Run Neovim health check
```

### Test Failure: "Neovim version is too old"
**Fix:** Upgrade Neovim to 0.9+
```bash
# macOS
brew upgrade neovim

# Linux - build from source or use package manager
nvim --version  # Check your version
```

## Running Tests in CI/CD

### GitHub Actions Example

```yaml
name: Neovim Config Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
      - run: |
          sudo apt-get update
          sudo apt-get install -y neovim git fish curl luac
      - run: bash tests/run_tests.sh
```

### Pre-commit Hook

Add to `.git/hooks/pre-commit`:

```bash
#!/bin/bash
bash tests/run_tests.sh || exit 1
```

Make it executable:
```bash
chmod +x .git/hooks/pre-commit
```

## Test Coverage Matrix

| Component | Shell Test | Lua Test | Status |
|-----------|-----------|----------|--------|
| File structure | ✓ | - | checks for missing files |
| Lua syntax | ✓ | - | validates all Lua files |
| Required tools | ✓ | - | git, fish, curl |
| Optional tools | ✓ | - | java, mvn, gradle, etc. |
| Clipboard | ✓ | ✓ | wl-copy, xclip, pbcopy |
| Module loading | - | ✓ | require() each module |
| Java setup | ✓ | ✓ | jdtls, spotless, wrappers |
| System integration | ✓ | ✓ | clipboard, git, fish |
| Version compatibility | - | ✓ | neovim >= 0.9 |
| Configuration | ✓ | - | init.lua, lazy.lua, etc. |
| Documentation | ✓ | - | README.md, docs/ |
| Git status | ✓ | - | commits, uncommitted changes |

## Debugging Test Failures

### Enable verbose output
```bash
bash -x tests/run_tests.sh
```

### Run individual file checks
```bash
# Check if file exists
test -f ~/.config/nvim/init.lua && echo "OK" || echo "Missing"

# Check Lua syntax
luac -p ~/.config/nvim/lua/config/lazy.lua

# Check if tool is available
command -v java && echo "Found" || echo "Missing"
```

### Test module loading manually
```bash
nvim -u ~/.config/nvim/init.lua -c "
  lua require('config.lazy')
  lua require('config.options')
  lua require('config.keymaps')
  lua require('config.commands')
  lua print('All modules loaded successfully')
" -c "q!"
```

## When to Run Tests

- **After git pull:** Ensure no breaking changes
- **After Neovim update:** Check version compatibility
- **After adding plugins:** Verify module loading
- **After system changes:** Validate tool availability
- **Before committing:** In CI/CD pipeline
- **During troubleshooting:** Identify specific failures

## Extending Tests

Add new tests by creating files matching the pattern `test_*.sh` or `test_*.lua` in the tests directory. Follow the existing format and output structure for consistency.

## Test Output Example

```
╔══════════════════════════════════════════════════════════════╗
║       NEOVIM CONFIGURATION VALIDATION TEST SUITE              ║
╚══════════════════════════════════════════════════════════════╝

ℹ Config directory: /home/john/.config/nvim

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
FILE STRUCTURE VALIDATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Found: init.lua
✓ Found: lua/config/lazy.lua
✓ Found: lua/lsp/java.lua
✓ Found: lua/plugins/java.lua

...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TEST SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total tests run: 45
Passed: 43
Failed: 0

✓ All critical tests passed!
```

## Troubleshooting the Test Suite

### "luac not found" warning
Install Lua to enable syntax checking:
```bash
# macOS
brew install lua

# Linux
sudo apt install lua5.3
```

### Tests hang or take too long
Some tests check for tool availability which can timeout:
- Run with reduced timeouts: `timeout 30 bash tests/run_tests.sh`
- Check individual commands: `command -v git`

### Cannot execute run_tests.sh
Make it executable:
```bash
chmod +x tests/run_tests.sh
```

## Performance Baseline

Expected test completion times:

- Shell tests: ~2-5 seconds
- Lua tests: ~1-3 seconds (when running in Neovim)
- Total suite: ~10-15 seconds

If tests are taking much longer, check:
- System load with `top`
- Disk I/O with `iotop`
- Network connectivity if tests require internet
