return {
  "rgroli/other.nvim",
  cmd = { "Other", "OtherSplit", "OtherVsplit" },
  config = function()
    require("other-nvim").setup({
      mappings = {
        -- Elixir mappings
        {
          pattern = "(.*)/lib/(.*)\\.ex$",
          target = "%1/test/%2_test.exs",
          context = "test",
        },
        {
          pattern = "(.*)/test/(.*)_test\\.exs$",
          target = "%1/lib/%2.ex",
          context = "implementation",
        },
        -- Dart/Flutter mappings
        {
          pattern = "(.*)/lib/(.*)\\.dart$",
          target = "%1/test/%2_test.dart",
          context = "test",
        },
        {
          pattern = "(.*)/test/(.*)_test\\.dart$",
          target = "%1/lib/%2.dart",
          context = "implementation",
        },
        -- Lua mappings
        {
          pattern = "(.*)/(.*)\\.(lua)$",
          target = "%1/spec/%2_spec.lua",
          context = "test",
        },
        {
          pattern = "(.*)/spec/(.*)_spec\\.lua$",
          target = "%1/%2.lua",
          context = "implementation",
        },
        -- JavaScript/TypeScript mappings
        {
          pattern = "(.*)/src/(.*)\\.jsx?$",
          target = "%1/__tests__/%2.test.js",
          context = "test",
        },
        {
          pattern = "(.*)/(.*)\\.(test)\\.jsx?$",
          target = "%1/src/%2.js",
          context = "implementation",
        },
      },
    })

    -- Keymaps
    local map = vim.keymap.set
    map("n", "<leader>oa", "<cmd>Other<cr>", { noremap = true, desc = "Open alternate file" })
    map("n", "<leader>os", "<cmd>OtherSplit<cr>", { noremap = true, desc = "Open alternate in split" })
    map("n", "<leader>ov", "<cmd>OtherVsplit<cr>", { noremap = true, desc = "Open alternate in vsplit" })
  end,
}
