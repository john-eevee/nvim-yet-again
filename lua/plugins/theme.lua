return {
  {
    -- Nord colorscheme
    "sainnhe/everforest",
    name = "everforest",
    priority = 1000,
    config = function()
      vim.g.nord_disable_background = true
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = "hard"
      vim.g.everforest_transparent_background = 2
      -- Use the nord colorscheme; this plugin doesn't require extra setup here.
      vim.cmd.colorscheme("everforest")
    end,
  },
}
