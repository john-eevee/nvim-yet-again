-- Additional plugins: opencode.nvim, other.nvim, and harpoon
return {
  -- opencode.nvim - Open URLs and API documentation
  {
    "dreamsofcode-io/opencode.nvim",
    cmd = { "OpenCodeHandler" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("opencode").setup({
        -- Handler to open URLs (default: system opener)
        handler = vim.fn.has("mac") == 1 and "open" or "xdg-open",
      })

      -- Keymaps
      local map = vim.keymap.set
      map("n", "<leader>od", "<cmd>OpenCodeHandler<cr>", { noremap = true, desc = "Open URL under cursor" })
    end,
  },

  -- other.nvim - Open alternate files (test files, implementation, etc.)
  {
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
  },

  -- harpoon - Quick navigation between marked files
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup({
        settings = {
          save_on_toggle = false,
          sync_on_ui_close = false,
          key = function()
            return vim.loop.cwd()
          end,
        },
      })

      -- Keymaps
      local map = vim.keymap.set

      -- Add file to harpoon
      map("n", "<leader>ha", function()
        harpoon:list():add()
      end, { noremap = true, desc = "Harpoon: Add file" })

      -- Show harpoon menu
      map("n", "<leader>hm", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { noremap = true, desc = "Harpoon: Toggle menu" })

      -- Jump to harpooned files (1-4)
      map("n", "<leader>h1", function()
        harpoon:list():select(1)
      end, { noremap = true, desc = "Harpoon: Jump to 1" })

      map("n", "<leader>h2", function()
        harpoon:list():select(2)
      end, { noremap = true, desc = "Harpoon: Jump to 2" })

      map("n", "<leader>h3", function()
        harpoon:list():select(3)
      end, { noremap = true, desc = "Harpoon: Jump to 3" })

      map("n", "<leader>h4", function()
        harpoon:list():select(4)
      end, { noremap = true, desc = "Harpoon: Jump to 4" })

      -- Navigate between harpoons
      map("n", "<leader>hp", function()
        harpoon:list():prev()
      end, { noremap = true, desc = "Harpoon: Previous" })

      map("n", "<leader>hn", function()
        harpoon:list():next()
      end, { noremap = true, desc = "Harpoon: Next" })
    end,
  },
}
