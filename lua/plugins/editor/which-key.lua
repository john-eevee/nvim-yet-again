-- ╔══════════════════════════════════════════════════════════════╗
-- ║         WHICH-KEY.NVIM - KEYMAP HELPER                       ║
-- ║     Display available keybindings on leader key press         ║
-- ╚══════════════════════════════════════════════════════════════╝

local wk = require("which-key")

wk.setup({
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 9,
    },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = false,
      nav = false,
      z = false,
      g = false,
    },
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  window = {
    border = "rounded",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
  show_help = true,
  show_keys = true,
  triggers = { "<leader>", "<localleader>" },
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },
})

-- Register keymaps for which-key display
wk.register({
  w = { name = "+window" },
  b = { name = "+buffer" },
  f = { name = "+file" },
  g = { name = "+goto" },
  s = { name = "+search" },
  c = { name = "+code" },
  d = { name = "+debug" },
  h = { name = "+help" },
  l = { name = "+lsp" },
  t = { name = "+telescope" },
  u = { name = "+ui" },
  x = { name = "+trouble" },
}, { prefix = "<leader>" })
