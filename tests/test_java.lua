-- ╔══════════════════════════════════════════════════════════════╗
-- ║         JAVA CONFIGURATION VALIDATION TEST                     ║
-- ║    Tests Java-specific setup and tool availability             ║
-- ╚══════════════════════════════════════════════════════════════╝

local function test_java_configuration()
  print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  print("JAVA CONFIGURATION TEST")
  print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

  local passed = 0
  local failed = 0
  local config_dir = vim.fn.expand("~/.config/nvim")

  -- Test 1: Check java.lua exists
  local java_lsp_path = config_dir .. "/lua/lsp/java.lua"
  if vim.fn.filereadable(java_lsp_path) == 1 then
    print("✓ lua/lsp/java.lua exists")
    passed = passed + 1
  else
    print("✗ lua/lsp/java.lua not found")
    failed = failed + 1
  end

  -- Test 2: Check java plugin exists
  local java_plugin_path = config_dir .. "/lua/plugins/java.lua"
  if vim.fn.filereadable(java_plugin_path) == 1 then
    print("✓ lua/plugins/java.lua exists")
    passed = passed + 1
  else
    print("✗ lua/plugins/java.lua not found")
    failed = failed + 1
  end

  -- Test 3: Check for jdtls in java.lua
  local java_lsp_content = vim.fn.readfile(java_lsp_path)
  local jdtls_found = false
  for _, line in ipairs(java_lsp_content) do
    if string.find(line, "jdtls") then
      jdtls_found = true
      break
    end
  end
  if jdtls_found then
    print("✓ jdtls configuration found in java.lua")
    passed = passed + 1
  else
    print("✗ jdtls configuration not found in java.lua")
    failed = failed + 1
  end

  -- Test 4: Check for Maven/Gradle detection in java.lua
  local maven_gradle_found = false
  for _, line in ipairs(java_lsp_content) do
    if string.find(line, "pom.xml") or string.find(line, "build.gradle") then
      maven_gradle_found = true
      break
    end
  end
  if maven_gradle_found then
    print("✓ Maven/Gradle detection found in java.lua")
    passed = passed + 1
  else
    print("✗ Maven/Gradle detection not found in java.lua")
    failed = failed + 1
  end

  -- Test 5: Check for Spotless in java plugin
  local java_plugin_content = vim.fn.readfile(java_plugin_path)
  local spotless_found = false
  for _, line in ipairs(java_plugin_content) do
    if string.find(line, "spotless") then
      spotless_found = true
      break
    end
  end
  if spotless_found then
    print("✓ Spotless formatter configuration found")
    passed = passed + 1
  else
    print("✗ Spotless formatter configuration not found")
    failed = failed + 1
  end

  -- Test 6: Check for wrapper script detection
  local wrapper_found = false
  for _, line in ipairs(java_plugin_content) do
    if string.find(line, "mvnw") or string.find(line, "gradlew") then
      wrapper_found = true
      break
    end
  end
  if wrapper_found then
    print("✓ Maven/Gradle wrapper detection found")
    passed = passed + 1
  else
    print("✗ Maven/Gradle wrapper detection not found")
    failed = failed + 1
  end

  -- Test 7: Check Java availability (optional)
  local java_check = vim.fn.system("command -v java 2>/dev/null")
  if vim.v.shell_error == 0 then
    print("✓ Java runtime available")
    passed = passed + 1
  else
    print("⚠ Java runtime not found (optional)")
  end

  print()
  print(string.format("Passed: %d, Failed: %d", passed, failed))

  return failed == 0
end

-- Run test
return test_java_configuration()
