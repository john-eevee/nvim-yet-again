-- ╔══════════════════════════════════════════════════════════════╗
-- ║          TROUBLE.NVIM - DIAGNOSTICS PANEL                    ║
-- ║    Pretty list of LSP diagnostics, references, QuickFix       ║
-- ╚══════════════════════════════════════════════════════════════╝

require("trouble").setup({
  position = "bottom",
  height = 10,
  width = 50,
  icons = true,
  mode = "document_diagnostics",
  severity = nil,
  fold_open = "v",
  fold_closed = ">",
  group = true,
  padding = true,
  indent_lines = true,
  win_config = { border = "rounded" },
  auto_open = false,
  auto_close = false,
  auto_preview = true,
  auto_jump = false,
  include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" },
  signs = {
    error = " ",
    warning = " ",
    hint = " ",
    information = " ",
    other = " ",
  },
  use_diagnostic_signs = false,
})

-- Additional keymaps
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<CR>", { desc = "Trouble: Quickfix" })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<CR>", { desc = "Trouble: Location list" })
vim.keymap.set("n", "<leader>xr", "<cmd>Trouble lsp_references<CR>", { desc = "Trouble: References" })
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble lsp_definitions<CR>", { desc = "Trouble: Definitions" })
