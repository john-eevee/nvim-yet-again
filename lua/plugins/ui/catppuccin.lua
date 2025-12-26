-- ╔══════════════════════════════════════════════════════════════╗
-- ║           CATPPUCCIN - BEAUTIFUL COLOR SCHEME                ║
-- ║     Minimal, pleasant theme with excellent contrast           ║
-- ╚══════════════════════════════════════════════════════════════╝

local catppuccin = require("catppuccin")

catppuccin.setup({
  flavour = "mocha",
  transparent_background = false,
  show_end_of_buffer = false,

  integrations = {
    cmp = true,
    gitsigns = true,
    telescope = true,
    treesitter = true,
    lsp_saga = false,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    which_key = true,
  },

  color_overrides = {
    mocha = {
      base = "#1e1e2e",
      crust = "#11111b",
    },
  },
})

-- Set the colorscheme
vim.cmd.colorscheme("catppuccin")
