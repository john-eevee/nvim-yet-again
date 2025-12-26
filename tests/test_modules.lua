-- ╔══════════════════════════════════════════════════════════════╗
-- ║       CONFIGURATION MODULE LOADING TEST                        ║
-- ║     Tests that all Lua modules can be required correctly       ║
-- ╚══════════════════════════════════════════════════════════════╝

local function test_module_loading()
  local modules_to_test = {
    -- Config modules
    { name = "config.lazy", required = true },
    { name = "config.options", required = true },
    { name = "config.keymaps", required = true },
    { name = "config.commands", required = true },

    -- LSP modules
    { name = "lsp.java", required = true },
  }

  print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  print("MODULE LOADING TEST")
  print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

  local passed = 0
  local failed = 0

  for _, module in ipairs(modules_to_test) do
    local ok, err = pcall(require, module.name)
    if ok then
      print(string.format("✓ %s loaded successfully", module.name))
      passed = passed + 1
    else
      if module.required then
        print(string.format("✗ FAILED to load %s: %s", module.name, err))
        failed = failed + 1
      else
        print(string.format("⚠ Optional module %s failed: %s", module.name, err))
      end
    end
  end

  print()
  print(string.format("Passed: %d, Failed: %d", passed, failed))

  return failed == 0
end

-- Run test
return test_module_loading()
