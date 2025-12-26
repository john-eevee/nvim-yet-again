-- ╔══════════════════════════════════════════════════════════════╗
-- ║        TODO-COMMENTS.NVIM - TODO HIGHLIGHTING                ║
-- ║     Highlight and navigate TODO, FIXME, HACK comments        ║
-- ╚══════════════════════════════════════════════════════════════╝

require("todo-comments").setup({
  signs = true,
  sign_priority = 8,
  keywords = {
    FIX = {
      icon = " ",
      color = "error",
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
  },
  gui_style = {
    fg = "BOLD",
    bg = "NONE",
  },
  merge_keywords = true,
  highlight = {
    multiline = false,
    multiline_pattern = "^.",
    multiline_context = 10,
    before = "",
    keyword = "wide",
    after = "fg",
    pattern = [[.*<(KEYWORDS)\s*:]],
    comments_only = true,
    max_line_len = 400,
    exclude = {},
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    pattern = [[\b(KEYWORDS)\b]],
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "TODO: Next" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "TODO: Previous" })

vim.keymap.set("n", "<leader>xt", "<cmd>TodoTelescope<CR>", { desc = "TODO: Show all" })
