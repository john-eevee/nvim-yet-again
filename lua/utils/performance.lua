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
  require("utils.logger").info("Profiling started. Run :profile stop when done.")
end

--- Stop performance profiling and display results
function M.stop_profile()
  vim.cmd("profile stop")
  require("utils.logger").info("Profile saved to /tmp/nvim_profile.log")
  vim.cmd("edit /tmp/nvim_profile.log")
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LAZY LOADING STATUS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Show lazy.nvim status
function M.show_lazy_status()
  local ok, status = pcall(function() return require("lazy.status").statusline() end)
  if ok and status then
    require("utils.logger").info("Lazy: " .. status)
  else
    require("utils.logger").warn("Lazy.nvim not loaded")
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
