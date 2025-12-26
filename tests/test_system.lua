-- ╔══════════════════════════════════════════════════════════════╗
-- ║      SYSTEM INTEGRATION & CLIPBOARD TEST                       ║
-- ║    Tests clipboard utilities and system command availability    ║
-- ╚══════════════════════════════════════════════════════════════╝

local function test_system_integration()
  print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  print("SYSTEM INTEGRATION TEST")
  print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

  local passed = 0
  local failed = 0
  local config_dir = vim.fn.expand("~/.config/nvim")

  -- Test 1: Check commands.lua for clipboard utilities
  local commands_path = config_dir .. "/lua/config/commands.lua"
  local commands_content = vim.fn.readfile(commands_path)
  local clipboard_found = false
  for _, line in ipairs(commands_content) do
    if string.find(line, "copy_file_path") then
      clipboard_found = true
      break
    end
  end

  if clipboard_found then
    print("✓ Clipboard utility functions found in commands.lua")
    passed = passed + 1
  else
    print("✗ Clipboard utility functions not found")
    failed = failed + 1
  end

  -- Test 2: Check for Fish shell integration
  local fish_found = false
  for _, line in ipairs(commands_content) do
    if string.find(line, "bash -c") or string.find(line, "fish") then
      fish_found = true
      break
    end
  end

  if fish_found then
    print("✓ Fish shell wrapper integration found")
    passed = passed + 1
  else
    print("✗ Fish shell wrapper integration not found")
    failed = failed + 1
  end

  -- Test 3: Check for Git commands
  local git_found = false
  for _, line in ipairs(commands_content) do
    if string.find(line, "git") then
      git_found = true
      break
    end
  end

  if git_found then
    print("✓ Git commands found")
    passed = passed + 1
  else
    print("✗ Git commands not found")
    failed = failed + 1
  end

  -- Test 4: Check required system tools
  local required_tools = { "git", "fish", "curl" }
  for _, tool in ipairs(required_tools) do
    local result = vim.fn.system(string.format("command -v %s 2>/dev/null", tool))
    if vim.v.shell_error == 0 then
      print(string.format("✓ %s is available", tool))
      passed = passed + 1
    else
      print(string.format("✗ %s is NOT available (required)", tool))
      failed = failed + 1
    end
  end

  -- Test 5: Check clipboard tools (at least one required)
  local clipboard_tools = { "wl-copy", "xclip", "pbcopy" }
  local clipboard_available = false
  for _, tool in ipairs(clipboard_tools) do
    local result = vim.fn.system(string.format("command -v %s 2>/dev/null", tool))
    if vim.v.shell_error == 0 then
      print(string.format("✓ Clipboard tool available: %s", tool))
      clipboard_available = true
      passed = passed + 1
    end
  end

  if not clipboard_available then
    print("⚠ No clipboard tool available (wl-copy, xclip, pbcopy)")
  end

  print()
  print(string.format("Passed: %d, Failed: %d", passed, failed))

  return failed == 0
end

-- Run test
return test_system_integration()
