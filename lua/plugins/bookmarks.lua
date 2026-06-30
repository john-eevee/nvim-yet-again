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
  end,
}
