return {
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
}
