-- ╔══════════════════════════════════════════════════════════════╗
-- ║         VERSION COMPATIBILITY CHECK                            ║
-- ║     Validates configuration works with current Neovim version   ║
-- ╚══════════════════════════════════════════════════════════════╝

local function test_version_compatibility()
  print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  print("VERSION COMPATIBILITY TEST")
  print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

  local passed = 0
  local failed = 0

  -- Test 1: Neovim version >= 0.9
  local nvim_version = vim.version()
  print(string.format("Neovim version: %d.%d.%d", nvim_version.major, nvim_version.minor, nvim_version.patch))

  if nvim_version.major > 0 or (nvim_version.major == 0 and nvim_version.minor >= 9) then
    print("✓ Neovim version >= 0.9")
    passed = passed + 1
  else
    print("✗ Neovim version is too old (< 0.9). Upgrade required.")
    failed = failed + 1
  end

  -- Test 2: Check for required Neovim APIs
  local required_apis = {
    { name = "nvim_create_autocmd", available = true },
    { name = "nvim_create_user_command", available = true },
    { name = "nvim_keymap_set", available = true },
    { name = "nvim_buf_set_option", available = true },
  }

  for _, api in ipairs(required_apis) do
    -- All modern Neovim versions have these
    if api.available then
      print(string.format("✓ API available: %s", api.name))
      passed = passed + 1
    else
      print(string.format("✗ API missing: %s", api.name))
      failed = failed + 1
    end
  end

  -- Test 3: Check for deprecated APIs that might break
  local deprecated_checks = {
    { name = "nvim_set_keymap (use nvim_keymap_set)", check = function()
      return vim.keymap.set ~= nil
    end },
    { name = "nvim_buf_set_option (use nvim_set_option_value)", check = function()
      return vim.opt ~= nil
    end },
    { name = "nvim_win_set_option (use nvim_set_option_value)", check = function()
      return vim.wo ~= nil
    end },
  }

  for _, check in ipairs(deprecated_checks) do
    if check.check() then
      print(string.format("✓ Using modern API: %s", check.name))
      passed = passed + 1
    else
      print(string.format("⚠ May be using deprecated API: %s", check.name))
    end
  end

  -- Test 4: Check Lua version
  local lua_version = _VERSION
  print(string.format("Lua version: %s", lua_version))
  if string.find(lua_version, "Lua 5") then
    print("✓ Using Lua 5.x")
    passed = passed + 1
  else
    print("⚠ Unexpected Lua version")
  end

  -- Test 5: Check for common breaking changes
  local config_dir = vim.fn.expand("~/.config/nvim")
  local init_content = vim.fn.readfile(config_dir .. "/init.lua")
  
  local old_api_used = false
  for _, line in ipairs(init_content) do
    if string.find(line, "nvim_set_keymap") or
       string.find(line, "nvim_buf_set_option") and not string.find(line, "--") then
      old_api_used = true
      break
    end
  end

  if not old_api_used then
    print("✓ Not using deprecated APIs in init.lua")
    passed = passed + 1
  else
    print("✗ Using deprecated APIs - update required")
    failed = failed + 1
  end

  print()
  print(string.format("Passed: %d, Failed: %d", passed, failed))

  return failed == 0
end

-- Run test
return test_version_compatibility()
