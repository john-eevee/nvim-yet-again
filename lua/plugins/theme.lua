return {
  "sainnhe/everforest",
  version = false,
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  -- Optional; default configuration will be used if setup isn't called.
  config = function()
    vim.g.everforest_background = 'soft'
    vim.g.everforest_better_performance = 1
    vim.cmd("colorscheme everforest")
  end,
}
