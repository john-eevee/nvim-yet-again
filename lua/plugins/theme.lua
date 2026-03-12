return {
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
}
