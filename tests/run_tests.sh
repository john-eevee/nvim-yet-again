#!/usr/bin/env bash

# ╔══════════════════════════════════════════════════════════════╗
# ║         NEOVIM CONFIGURATION TEST RUNNER                      ║
# ║      Validates config structure, syntax, and dependencies     ║
# ╚══════════════════════════════════════════════════════════════╝

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$(dirname "$SCRIPT_DIR")"
PASSED=0
FAILED=0
TESTS=()

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# UTILITIES
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

log_info() {
  echo -e "${BLUE}ℹ${NC} $1"
}

log_pass() {
  echo -e "${GREEN}✓${NC} $1"
  ((PASSED++))
}

log_fail() {
  echo -e "${RED}✗${NC} $1"
  ((FAILED++))
}

log_warn() {
  echo -e "${YELLOW}⚠${NC} $1"
}

log_section() {
  echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${BLUE}$1${NC}"
  echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# FILE STRUCTURE TESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

test_files_exist() {
  log_section "FILE STRUCTURE VALIDATION"

  local required_files=(
    "init.lua"
    "lua/config/lazy.lua"
    "lua/config/keymaps.lua"
    "lua/config/commands.lua"
    "lua/lsp/java.lua"
    "lua/plugins/java.lua"
  )

  for file in "${required_files[@]}"; do
    if [[ -f "$CONFIG_DIR/$file" ]]; then
      log_pass "Found: $file"
    else
      log_fail "Missing: $file"
    fi
  done
}

test_directories_exist() {
  log_info "Checking directory structure..."

  local required_dirs=(
    "lua/config"
    "lua/lsp"
    "lua/plugins"
    "docs"
  )

  for dir in "${required_dirs[@]}"; do
    if [[ -d "$CONFIG_DIR/$dir" ]]; then
      log_pass "Found directory: $dir"
    else
      log_fail "Missing directory: $dir"
    fi
  done
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# LUA SYNTAX TESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

test_lua_syntax() {
  log_section "LUA SYNTAX VALIDATION"

  # Find all Lua files
  local lua_files
  lua_files=$(find "$CONFIG_DIR/lua" -name "*.lua" 2>/dev/null || true)
  
  if [[ -z "$lua_files" ]]; then
    log_fail "No Lua files found in lua/"
    return
  fi

  local count=0
  while IFS= read -r file; do
    count=$((count + 1))
    # Test if file can be parsed by luac (Lua compiler)
    if command -v luac &> /dev/null; then
      if luac -p "$file" 2>/dev/null; then
        log_pass "Syntax OK: $(basename "$file")"
      else
        log_fail "Syntax error in: $(basename "$file")"
      fi
    else
      log_warn "luac not found, skipping syntax check for: $(basename "$file")"
    fi
  done <<< "$lua_files"

  [[ $count -gt 0 ]] && log_info "Checked $count Lua files"
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# EXTERNAL TOOLS TESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

test_required_tools() {
  log_section "REQUIRED TOOLS VALIDATION"

  local required_tools=(
    "git"
    "fish"
    "curl"
  )

  for tool in "${required_tools[@]}"; do
    if command -v "$tool" &> /dev/null; then
      local version
      version=$("$tool" --version 2>&1 | head -n 1)
      log_pass "Found: $tool ($version)"
    else
      log_fail "Missing: $tool"
    fi
  done
}

test_optional_tools() {
  log_section "OPTIONAL TOOLS VALIDATION"

  local optional_tools=(
    "java:Java runtime (for jdtls)"
    "mvn:Maven (for Java projects)"
    "gradle:Gradle (for Java projects)"
    "node:Node.js (for TypeScript/JavaScript)"
    "python3:Python (for Python support)"
    "rustc:Rust (for Rust support)"
    "go:Go (for Go support)"
    "luac:Lua compiler (for syntax checking)"
  )

  for item in "${optional_tools[@]}"; do
    IFS=':' read -r tool desc <<< "$item"
    if command -v "$tool" &> /dev/null; then
      log_pass "Found: $desc"
    else
      log_warn "Optional: $desc not installed"
    fi
  done
}

test_clipboard_tools() {
  log_section "CLIPBOARD UTILITIES VALIDATION"

  local clipboard_tools=(
    "wl-copy:Wayland clipboard"
    "xclip:X11 clipboard"
    "pbcopy:macOS clipboard"
  )

  local found=false
  for item in "${clipboard_tools[@]}"; do
    IFS=':' read -r tool desc <<< "$item"
    if command -v "$tool" &> /dev/null; then
      log_pass "Found: $desc"
      found=true
    fi
  done

  if ! $found; then
    log_warn "No clipboard utility found (wl-copy, xclip, or pbcopy)"
  fi
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# CONFIGURATION TESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

test_init_lua() {
  log_section "INIT.LUA VALIDATION"

  if [[ ! -f "$CONFIG_DIR/init.lua" ]]; then
    log_fail "init.lua not found"
    return
  fi

  # Check for required requires
  if grep -q "require.*config.lazy" "$CONFIG_DIR/init.lua"; then
    log_pass "Found lazy.nvim initialization"
  else
    log_fail "Missing lazy.nvim initialization"
  fi

  if grep -q "require.*config.*settings\|require.*config.*options" "$CONFIG_DIR/init.lua"; then
    log_pass "Found settings/options configuration"
  else
    log_fail "Missing settings/options configuration"
  fi

  if grep -q "require.*config.keymaps" "$CONFIG_DIR/init.lua"; then
    log_pass "Found keymaps configuration"
  else
    log_fail "Missing keymaps configuration"
  fi
}

test_lazy_config() {
  log_section "LAZY.NVIM CONFIGURATION VALIDATION"

  local lazy_file="$CONFIG_DIR/lua/config/lazy.lua"
  if [[ ! -f "$lazy_file" ]]; then
    log_fail "lazy.lua not found"
    return
  fi

  # Check for plugin specs
  if grep -q "nvim-treesitter" "$lazy_file"; then
    log_pass "Found treesitter plugin"
  else
    log_fail "Missing treesitter plugin"
  fi

  if grep -q "nvim-telescope" "$lazy_file"; then
    log_pass "Found telescope plugin"
  else
    log_fail "Missing telescope plugin"
  fi

  if grep -q "nvim-lspconfig" "$lazy_file"; then
    log_pass "Found LSP config plugin"
  else
    log_fail "Missing LSP config plugin"
  fi

  if grep -q "conform" "$lazy_file"; then
    log_pass "Found conform formatter"
  else
    log_fail "Missing conform formatter"
  fi

  # Check for correct LSP java require
  if grep -q 'require("lsp.java")' "$lazy_file"; then
    log_pass "LSP java module correctly referenced"
  else
    log_fail "LSP java module not correctly referenced"
  fi
}

test_java_setup() {
  log_section "JAVA SETUP VALIDATION"

  local java_lsp="$CONFIG_DIR/lua/lsp/java.lua"
  if [[ ! -f "$java_lsp" ]]; then
    log_fail "java.lua LSP file not found"
    return
  fi

  if grep -q "jdtls" "$java_lsp"; then
    log_pass "Found jdtls configuration"
  else
    log_fail "Missing jdtls configuration"
  fi

  # Check for Maven/Gradle detection
  if grep -q "pom.xml\|build.gradle" "$java_lsp"; then
    log_pass "Found Maven/Gradle detection"
  else
    log_fail "Missing Maven/Gradle detection"
  fi

  local java_plugin="$CONFIG_DIR/lua/plugins/java.lua"
  if [[ ! -f "$java_plugin" ]]; then
    log_fail "java.lua plugin file not found"
    return
  fi

  # Check for Spotless formatter
  if grep -q "spotless" "$java_plugin"; then
    log_pass "Found Spotless formatter configuration"
  else
    log_fail "Missing Spotless formatter configuration"
  fi

  # Check for Maven and Gradle wrapper detection
  if grep -q "mvnw\|gradlew" "$java_plugin"; then
    log_pass "Found wrapper script detection (Maven/Gradle)"
  else
    log_fail "Missing wrapper script detection"
  fi
}

test_keymaps() {
  log_section "KEYMAPS VALIDATION"

  local keymaps_file="$CONFIG_DIR/lua/config/keymaps.lua"
  if [[ ! -f "$keymaps_file" ]]; then
    log_fail "keymaps.lua not found"
    return
  fi

  # Check for keymaps configuration
  if grep -q "vim.keymap.set\|keymap(" "$keymaps_file"; then
    log_pass "Found keymaps definitions"
  else
    log_fail "Missing keymaps definitions"
  fi

  # Leader key can be in keymaps or settings
  if grep -q "mapleader" "$keymaps_file" "$CONFIG_DIR/lua/config/settings.lua" 2>/dev/null; then
    log_pass "Found leader key configuration"
  else
    log_warn "Leader key configuration not found in expected locations"
  fi
}

test_commands() {
  log_section "CUSTOM COMMANDS VALIDATION"

  local commands_file="$CONFIG_DIR/lua/config/commands.lua"
  if [[ ! -f "$commands_file" ]]; then
    log_fail "commands.lua not found"
    return
  fi

  # Check for clipboard utilities
  if grep -q "copy_file_path\|copy_file_path_with_line" "$commands_file"; then
    log_pass "Found clipboard utilities"
  else
    log_fail "Missing clipboard utilities"
  fi

  # Check for test detection
  if grep -q "detect.*maven\|detect.*gradle\|detect.*flutter" "$commands_file"; then
    log_pass "Found test auto-detection"
  else
    log_warn "Test auto-detection may be incomplete"
  fi
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# DOCUMENTATION TESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

test_documentation() {
  log_section "DOCUMENTATION VALIDATION"

  local docs=(
    "README.md"
    "docs/JAVA_SETUP.md"
  )

  for doc in "${docs[@]}"; do
    if [[ -f "$CONFIG_DIR/$doc" ]]; then
      log_pass "Found: $doc"
      local lines
      lines=$(wc -l < "$CONFIG_DIR/$doc")
      log_info "  ($lines lines)"
    else
      log_warn "Missing: $doc"
    fi
  done
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# GIT VALIDATION
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

test_git_status() {
  log_section "GIT STATUS"

  if [[ ! -d "$CONFIG_DIR/.git" ]]; then
    log_warn "Not a git repository"
    return
  fi

  local commit_count
  commit_count=$(cd "$CONFIG_DIR" && git rev-list --count HEAD)
  log_info "Commits: $commit_count"

  local last_commit
  last_commit=$(cd "$CONFIG_DIR" && git log -1 --pretty=format:"%h - %s")
  log_info "Last commit: $last_commit"

  local uncommitted
  uncommitted=$(cd "$CONFIG_DIR" && git status --porcelain | wc -l)
  if [[ $uncommitted -eq 0 ]]; then
    log_pass "Working tree clean"
  else
    log_warn "Uncommitted changes: $uncommitted"
  fi
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# MAIN TEST RUNNER
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

main() {
  echo -e "${BLUE}"
  echo "╔══════════════════════════════════════════════════════════════╗"
  echo "║       NEOVIM CONFIGURATION VALIDATION TEST SUITE              ║"
  echo "╚══════════════════════════════════════════════════════════════╝"
  echo -e "${NC}"
  log_info "Config directory: $CONFIG_DIR"
  echo

  # Run all tests
  test_files_exist
  test_directories_exist
  test_lua_syntax
  test_required_tools
  test_optional_tools
  test_clipboard_tools
  test_init_lua
  test_lazy_config
  test_java_setup
  test_keymaps
  test_commands
  test_documentation
  test_git_status

  # Print summary
  echo
  log_section "TEST SUMMARY"
  local total=$((PASSED + FAILED))
  echo -e "Total tests run: $total"
  echo -e "${GREEN}Passed: $PASSED${NC}"
  if [[ $FAILED -gt 0 ]]; then
    echo -e "${RED}Failed: $FAILED${NC}"
  else
    echo -e "${GREEN}Failed: $FAILED${NC}"
  fi
  echo

  # Exit code
  if [[ $FAILED -eq 0 ]]; then
    echo -e "${GREEN}✓ All critical tests passed!${NC}"
    exit 0
  else
    echo -e "${RED}✗ Some tests failed. Review the output above.${NC}"
    exit 1
  fi
}

# Run main
main
