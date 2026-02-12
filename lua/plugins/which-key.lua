return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>f", group = "Finder" },
      { "<leader>g", group = "Go To" },
      { "<leader>s", group = "Search" },
      { "<leader>u", group = "UI" },
      { "<leader>w", group = "Window" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
  end,
}
