-- ╔══════════════════════════════════════════════════════════════╗
-- ║         NVIM-NOTIFY - NOTIFICATION SYSTEM                    ║
-- ║    Beautiful, persistent notification windows                 ║
-- ╚══════════════════════════════════════════════════════════════╝

require("notify").setup({
  -- Animation style ("fade", "slide", "fade_in_slide_out", "none")
  stages = "fade_in_slide_out",

  -- Default timeout for notifications in ms
  timeout = 2000,

  -- For stages that change opacity this is treated as the highlight behind the window
  -- For stages that change height, this is treated as the highlight of the bar of change
  background_colour = "#000000",

  -- Highlight behind the window for stages that change the background colour.
  highlight = "Normal",

  icons = {
    ERROR = " ",
    WARN = " ",
    INFO = " ",
    DEBUG = " ",
    TRACE = "✎",
  },

  on_open = nil,
  on_close = nil,

  -- Max number of columns for messages
  max_width = 100,
  max_height = 10,

  -- all the level dictionary values used for log messages
  level = vim.log.levels.INFO,
})

-- Set vim.notify to use nvim-notify
vim.notify = require("notify")
