return {
  "karb94/neoscroll.nvim",
  enabed = false,
  event = "WinScrolled",
  opts = {
    mappings = {
      "<C-u>",
      "<C-d>",
      "<C-b>",
      "<C-f>",
      "<C-y>",
      "<C-e>",
      "zt",
      "zz",
      "zb",
    },
    hide_cursor = true,
    stop_eof = true,
    respect_scrolloff = false,
    easing_function = "quadratic",
  },
}
