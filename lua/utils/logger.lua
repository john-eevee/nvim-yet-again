-- Simple file-based logger for Neovim (replaces noisy `vim.notify` usage)
local M = {}

local log_path = vim.fn.stdpath("cache") .. "/nvim.log"

local function safe_tostring(val)
  if type(val) == "string" then
    return val
  end
  local ok, s = pcall(vim.inspect, val)
  if ok then return s end
  return tostring(val)
end

local function write(level, msg)
  local ok, f = pcall(io.open, log_path, "a")
  if not ok or not f then
    -- Fall back to vim.notify if file can't be written
    pcall(vim.notify, string.format("[%s] %s", level:upper(), safe_tostring(msg)), vim.log.levels.ERROR)
    return
  end
  local time = os.date("%Y-%m-%d %H:%M:%S")
  f:write(string.format("%s [%s] %s\n", time, level:upper(), safe_tostring(msg)))
  f:close()
end

function M.info(msg)
  write("info", msg)
end

function M.warn(msg)
  write("warn", msg)
end

function M.error(msg)
  write("error", msg)
end

function M.open()
  -- Open log file in a new buffer
  local path = log_path
  if vim.fn.filereadable(path) == 0 then
    -- create empty file
    local ok, f = pcall(io.open, path, "w")
    if ok and f then f:close() end
  end
  vim.cmd(" tabnew " .. path)
end

-- Expose a user command to view logs
vim.api.nvim_create_user_command("ViewLog", function()
  M.open()
end, { desc = "Open Neovim log file" })

return M
