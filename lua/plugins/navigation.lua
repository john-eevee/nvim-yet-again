-- Additional plugins: opencode.nvim, other.nvim, and harpoon
return {
{
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on the type or field.
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
    vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

    -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o…".
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
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
