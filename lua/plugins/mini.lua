-- ╔══════════════════════════════════════════════════════════════╗
-- ║          MINI.NVIM - COLLECTION OF MINI PLUGINS              ║
-- ║     Lightweight, zero-dependency utility plugins              ║
-- ╚══════════════════════════════════════════════════════════════╝

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MINI.AI - AI ENHANCED TEXT OBJECTS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

require("mini.ai").setup({
  n_lines = 50,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MINI.INDENTSCOPE - VISUAL INDENT GUIDES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

require("mini.indentscope").setup({
  symbol = "│",
  options = {
    try_as_border = true,
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MINI.SURROUND - SURROUND TEXT OBJECTS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

require("mini.surround").setup({
  mappings = {
    add = "ys",
    delete = "ds",
    find = "gzf",
    find_left = "gzF",
    highlight = "gzh",
    replace = "cs",
    update_n_lines = "gzn",
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MINI.MOVE - MOVE LINES & BLOCKS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

require("mini.move").setup({
  mappings = {
    left = "<M-h>",
    right = "<M-l>",
    down = "<M-j>",
    up = "<M-k>",

    line_left = "<M-h>",
    line_right = "<M-l>",
    line_down = "<M-j>",
    line_up = "<M-k>",
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MINI.PAIRS - BRACKET PAIRING
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

require("mini.pairs").setup({
  modes = { insert = true, command = false, terminal = false },
  skip_next = [=[[%w%%%'%"%.]]=],
  skip_ts = { "string" },
  skip_unbalanced = true,
  markdown = true,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MINI.ALIGN - TEXT ALIGNMENT
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

require("mini.align").setup()

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MINI.BRACKETED - BRACKETED NAVIGATION
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

require("mini.bracketed").setup({
  buffer = { suffix = "b", options = {} },
  comment = { suffix = "c", options = {} },
  conflict = { suffix = "x", options = {} },
  diagnostic = { suffix = "d", options = {} },
  file = { suffix = "f", options = {} },
  indent = { suffix = "i", options = {} },
  jump = { suffix = "j", options = {} },
  location = { suffix = "l", options = {} },
  oldfile = { suffix = "o", options = {} },
  quickfix = { suffix = "q", options = {} },
  treesitter = { suffix = "t", options = {} },
  undo = { suffix = "u", options = {} },
  window = { suffix = "w", options = {} },
  yank = { suffix = "y", options = {} },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MINI.SESSIONS - SESSION MANAGEMENT
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

require("mini.sessions").setup({
  autoread = false,
  autowrite = true,
  default = "",
  file = "",
  force = { read = false, write = false },
  verbose = { read = false, write = false, delete = false },
})

-- Add keymaps for sessions
vim.keymap.set("n", "<leader>ss", "<cmd>lua MiniSessions.write()<CR>", { desc = "Session: Save" })
vim.keymap.set("n", "<leader>sr", "<cmd>lua MiniSessions.read()<CR>", { desc = "Session: Read" })
vim.keymap.set("n", "<leader>sd", "<cmd>lua MiniSessions.delete()<CR>", { desc = "Session: Delete" })
