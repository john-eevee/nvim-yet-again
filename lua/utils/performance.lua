-- ╔══════════════════════════════════════════════════════════════╗
-- ║         PERFORMANCE MONITORING & OPTIMIZATION                ║
-- ║    Tools to measure and optimize neovim startup and runtime  ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- STARTUP TIME PROFILING
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Start performance profiling
function M.start_profile()
  vim.cmd("profile start /tmp/nvim_profile.log")
  vim.cmd("profile func *")
  vim.cmd("profile file *")
  vim.notify("Profiling started. Run :profile stop when done.", vim.log.levels.INFO)
end

--- Stop performance profiling and display results
function M.stop_profile()
  vim.cmd("profile stop")
  vim.notify("Profile saved to /tmp/nvim_profile.log", vim.log.levels.INFO)
  vim.cmd("edit /tmp/nvim_profile.log")
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LAZY LOADING STATUS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Show lazy.nvim status
function M.show_lazy_status()
  if vim.fn.exists("*lazy#status") then
    vim.notify(require("lazy.status").statusline())
  else
    vim.notify("Lazy.nvim not loaded", vim.log.levels.WARN)
  end
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- COMMANDS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.api.nvim_create_user_command("ProfileStart", M.start_profile, { desc = "Start performance profile" })
vim.api.nvim_create_user_command("ProfileStop", M.stop_profile, { desc = "Stop performance profile" })
vim.api.nvim_create_user_command("LazyStatus", M.show_lazy_status, { desc = "Show lazy.nvim status" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.keymap.set(
  "n",
  "<leader>ps",
  "<cmd>ProfileStart<CR>",
  { noremap = true, silent = true, desc = "Performance: Start profile" }
)

vim.keymap.set(
  "n",
  "<leader>pp",
  "<cmd>ProfileStop<CR>",
  { noremap = true, silent = true, desc = "Performance: Stop profile" }
)

return M
