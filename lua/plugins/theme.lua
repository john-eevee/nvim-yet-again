return {
  -- {
  --   -- Nord colorscheme
  --   "sainnhe/everforest",
  --   name = "everforest",
  --   priority = 1000,
  --   config = function()
  --     vim.g.nord_disable_background = true
  --     vim.g.everforest_enable_italic = true
  --     vim.g.everforest_background = "hard"
  --     vim.g.everforest_transparent_background = 2
  --     -- Use the nord colorscheme; this plugin doesn't require extra setup here.
  --     vim.cmd.colorscheme("everforest")
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
    config = function(_)
      vim.cmd.colorscheme("tokyonight")
    end,
    enabled = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd.colorscheme("catppuccin")
      -- Surface0 (#313244): Apply this value for the most subtle, barely visible boundary.
      -- Surface1 (#45475a): This is the mathematically optimal, standard muted color for UI borders in the Mocha theme.
      -- Surface2 (#585b70): Select this specific hex code if you require a slightly more distinct line.
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#45475a", bg = "NONE" })
    end,
  },
}
