-- ╔══════════════════════════════════════════════════════════════╗
-- ║        PROJECT.NVIM - PROJECT DETECTION & MANAGEMENT          ║
-- ║     Auto-detect projects and manage workspace setup           ║
-- ╚══════════════════════════════════════════════════════════════╝

require("project_nvim").setup({
  manual_mode = false,
  detection_methods = { "lsp", "pattern" },
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pyproject.toml", "Cargo.toml" },
  ignore_lsp = {},
  exclude_dirs = {},
  show_hidden = false,
  silent_chdir = true,
  datapath = vim.fn.stdpath("data"),
})

-- Integrate with Telescope
require("telescope").load_extension("projects")

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.keymap.set(
  "n",
  "<leader>fp",
  "<cmd>Telescope projects<CR>",
  { noremap = true, silent = true, desc = "Projects: Open project" }
)
