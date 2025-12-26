-- ╔══════════════════════════════════════════════════════════════╗
-- ║       CODECOMPANION - GITHUB COPILOT INTEGRATION              ║
-- ║    AI-powered coding assistant with context awareness         ║
-- ╚══════════════════════════════════════════════════════════════╝

local codecompanion = require("codecompanion")

codecompanion.setup({
  strategies = {
    chat = "default",
    inline = "default",
  },
  adapters = {
    copilot = require("codecompanion.adapters").use("copilot"),
  },
  keymaps = {
    send = "<C-s>",
    close = "<C-c>",
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat<CR>", { desc = "CodeCompanion: Chat" })
vim.keymap.set("v", "<leader>cc", "<cmd>CodeCompanionChat<CR>", { desc = "CodeCompanion: Chat" })
vim.keymap.set("n", "<leader>ca", "<cmd>CodeCompanionActions<CR>", { desc = "CodeCompanion: Actions" })
vim.keymap.set("v", "<leader>ca", "<cmd>CodeCompanionActions<CR>", { desc = "CodeCompanion: Actions" })
