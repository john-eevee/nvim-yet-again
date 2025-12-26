-- ╔══════════════════════════════════════════════════════════════╗
-- ║         SEARCH & REPLACE UTILITIES                            ║
-- ║    Enhanced project-wide search and replace functionality     ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- GREP CONFIGURATIONS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Configure ripgrep for better performance
local grep_options = {
  hidden = true,
  follow = true,
}

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- PROJECT-WIDE SEARCH & REPLACE
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Global find and replace using quickfix list
--- Usage: :Gsub pattern replacement
---@param pattern string
---@param replacement string
local function global_find_replace(pattern, replacement)
  -- Use Telescope for finding
  local builtin = require("telescope.builtin")
  builtin.live_grep({
    default_text = pattern,
    cwd = vim.fn.getcwd(),
  })

  -- After selection with Telescope, use this command:
  -- :cfdo %s/pattern/replacement/g | update
  vim.notify("Use :cfdo %s/" .. pattern .. "/" .. replacement .. "/g | update", vim.log.levels.INFO)
end

--- Search word under cursor
---@return nil
function M.search_word_under_cursor()
  local word = vim.fn.expand("<cword>")
  local builtin = require("telescope.builtin")
  builtin.live_grep({
    default_text = word,
    cwd = vim.fn.getcwd(),
  })
end

--- Replace word in file (current buffer)
---@param old_word string
---@param new_word string
local function replace_in_buffer(old_word, new_word)
  local cmd = ":%s/" .. old_word .. "/" .. new_word .. "/gc"
  vim.cmd(cmd)
end

--- Replace word in directory (project-wide)
---@param old_word string
---@param new_word string
---@param file_pattern string (optional, e.g. "*.lua")
local function replace_in_project(old_word, new_word, file_pattern)
  file_pattern = file_pattern or "*"
  local cmd = string.format("cdo %%s/%s/%s/gc | update", old_word, new_word)
  vim.notify("Execute: " .. cmd, vim.log.levels.INFO)
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- COMMANDS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Search for word under cursor
vim.api.nvim_create_user_command("SearchWord", function()
  M.search_word_under_cursor()
end, { desc = "Search word under cursor" })

--- Quick buffer search and replace
vim.api.nvim_create_user_command("ReplaceBuffer", function(opts)
  local args = vim.split(opts.args, " ")
  if #args < 2 then
    vim.notify("Usage: :ReplaceBuffer old new", vim.log.levels.ERROR)
    return
  end
  replace_in_buffer(args[1], args[2])
end, {
  nargs = "+",
  desc = "Replace in current buffer",
})

return M
