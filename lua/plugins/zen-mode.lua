return {
  "folke/zen-mode.nvim",
  config = function()
    require("zen-mode").setup({
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          cmdheight = 0,
        },
        twilight = {
          enabled = false,
        },
        gitsigns = {
          enabled = false,
        },
        tmux = {
          enabled = false,
        },
        kitty = {
          enabled = false,
          font = "+2",
        },
        alacritty = {
          enabled = false,
          font = "14",
        },
        wezterm = {
          enabled = false,
          font = "+2",
        },
      },
    })
  end,
  keys = {
    {
      "<leader>zz",
      function()
        require("zen-mode").toggle()
      end,
      desc = "Zen Mode: Toggle",
    },
  },
}
