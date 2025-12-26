-- ╔══════════════════════════════════════════════════════════════╗
-- ║         LEAP.NVIM - FAST JUMPING & MOTIONS                   ║
-- ║    AceJump-style character jumping with 's' and 'S'          ║
-- ╚══════════════════════════════════════════════════════════════╝

require("leap").setup({
  case_sensitive = false,
  highlight_unlabeled_phase_one_targets = false,
  max_phase_one_targets = nil,
  equivalence_classes = { " \t\r\n" },
  substitute_chars = { ["\r"] = "¬" },
  safe_labels = "sdfjkl",
  labels = "sdfjklewcmpugvzoxqkla",
  max_highlighted_traversal_size = 250,
  opts = {
    normalized = true,
  },
})

-- Configure with extended keymaps
vim.api.nvim_set_keymap("n", "s", "<Plug>(leap-forward)", { noremap = false })
vim.api.nvim_set_keymap("n", "S", "<Plug>(leap-backward)", { noremap = false })
vim.api.nvim_set_keymap("x", "s", "<Plug>(leap-forward)", { noremap = false })
vim.api.nvim_set_keymap("x", "S", "<Plug>(leap-backward)", { noremap = false })
vim.api.nvim_set_keymap("o", "s", "<Plug>(leap-forward)", { noremap = false })
vim.api.nvim_set_keymap("o", "S", "<Plug>(leap-backward)", { noremap = false })
