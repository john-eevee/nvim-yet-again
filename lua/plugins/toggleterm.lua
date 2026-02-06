return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

    vim.keymap.set("n", "<leader>tt", function()
      lazygit:toggle()
    end, { desc = "Toggle lazygit", noremap = true })
  end,
}
