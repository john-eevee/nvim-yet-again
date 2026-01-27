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
  win = {
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
wk.add({
  { "<leader>-", desc = "Explorer: Oil" },
  { "<leader>b", group = "buffer" },
  { "<leader>c", group = "code" },
  { "<leader>d", group = "debug" },
  { "<leader>e", group = "diagnostic" },
  { "<leader>f", group = "file/finder" },
  { "<leader>g", group = "goto" },
  { "<leader>h", group = "help/history" },
  { "<leader>j", group = "jump/lsp" },
  { "<leader>k", group = "keymaps" },
  { "<leader>l", group = "lsp" },
  { "<leader>m", group = "marks" },
  { "<leader>s", group = "search" },
  { "<leader>t", group = "terminal/tests" },
  { "<leader>u", group = "ui/utils" },
  { "<leader>w", group = "window" },
  { "<leader>x", group = "trouble/quickfix" },
  { "<leader>y", group = "yank/clipboard" },
  { "<leader>z", group = "fold" },
})
