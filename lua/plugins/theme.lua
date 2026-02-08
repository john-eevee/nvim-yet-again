return {
  {
    -- Nord colorscheme
    'shaunsingh/nord.nvim',
    name = 'nord',
    priority = 1000,
    config = function()
      -- Use the nord colorscheme; this plugin doesn't require extra setup here.
      vim.cmd.colorscheme('nord')
    end,
  },
}
