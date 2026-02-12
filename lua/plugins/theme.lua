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
        transparent_background = true,
        float = {
          transparent = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
