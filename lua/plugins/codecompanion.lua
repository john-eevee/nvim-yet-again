-- ╔══════════════════════════════════════════════════════════════╗
-- ║       CODECOMPANION - GITHUB COPILOT INTEGRATION              ║
-- ║    AI-powered coding assistant with context awareness         ║
-- ║    + Custom Agents (Planner, Git Operator)                    ║
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

-- Custom agents (loaded from codecompanion_agents.lua)
-- <leader>cp - Planner Agent (task breakdown & todos)
-- <leader>cg - Git Operator (commit management & history analysis)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- INFO: Available CodeCompanion Commands
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--
-- :CodeCompanionChat              Open main chat interface
-- :CodeCompanionActions           Quick action menu
-- :PlannerAgent                   Open Planner (task breakdown)
-- :GitOperator                    Open Git Operator (history/commits)
--
-- Keymaps:
-- <leader>cc                      CodeCompanion Chat
-- <leader>ca                      CodeCompanion Actions
-- <leader>cp                      Planner Agent
-- <leader>cg                      Git Operator
