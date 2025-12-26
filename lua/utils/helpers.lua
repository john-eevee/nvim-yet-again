-- ╔══════════════════════════════════════════════════════════════╗
-- ║         UTILITY FUNCTIONS FOR COMMON OPERATIONS               ║
-- ║    Helper functions used throughout the configuration         ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- BUFFER & FILE UTILITIES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Get the root directory of the current project
--- Returns git root or current working directory
---@return string
function M.get_project_root()
  local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
  if vim.v.shell_error == 0 then
    return git_root
  end
  return vim.fn.getcwd()
end

--- Get the current file's directory
---@return string
function M.get_file_dir()
  return vim.fn.expand("%:p:h")
end

--- Check if file exists
---@param path string
---@return boolean
function M.file_exists(path)
  return vim.fn.filereadable(path) == 1
end

--- Check if directory exists
---@param path string
---@return boolean
function M.dir_exists(path)
  return vim.fn.isdirectory(path) == 1
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- STRING UTILITIES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Trim whitespace from string
---@param s string
---@return string
function M.trim(s)
  return s:match("^%s*(.-)%s*$")
end

--- Split string by delimiter
---@param str string
---@param delim string
---@return table
function M.split(str, delim)
  local result = {}
  for part in str:gmatch("[^" .. delim .. "]+") do
    table.insert(result, part)
  end
  return result
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- NOTIFICATION UTILITIES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Show info notification (logged to file)
---@param msg string
function M.notify_info(msg)
  require("utils.logger").info("Neovim: " .. msg)
end

--- Show warning notification (logged to file)
---@param msg string
function M.notify_warn(msg)
  require("utils.logger").warn("Neovim: " .. msg)
end

--- Show error notification (logged to file)
---@param msg string
function M.notify_error(msg)
  require("utils.logger").error("Neovim: " .. msg)
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TOGGLE UTILITIES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Toggle a boolean option
---@param opt string vim option name
---@return boolean
function M.toggle_option(opt)
  local current = vim.opt[opt]._value
  vim.opt[opt] = not current
  local state = vim.opt[opt]._value and "on" or "off"
  M.notify_info(opt .. " is now " .. state)
  return vim.opt[opt]._value
end

--- Toggle background light/dark
function M.toggle_background()
  if vim.opt.background._value == "light" then
    vim.opt.background = "dark"
  else
    vim.opt.background = "light"
  end
  M.notify_info("Background: " .. vim.opt.background._value)
end

return M
