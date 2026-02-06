-- Smart Tab Jumper Utility
-- Jumps over closing brackets/quotes when Tab is pressed in insert mode
-- Integrated with nvim-cmp for seamless autocompletion
-- Supports: () [] {} <> '' "" `` ; : , .

local M = {}

--- Characters that can be jumped over
local JUMP_CHARS = {
  ["'"] = true,
  ['"'] = true,
  ["`"] = true,
  ["("] = true,
  [")"] = true,
  ["["] = true,
  ["]"] = true,
  ["{"] = true,
  ["}"] = true,
  ["<"] = true,
  [">"] = true,
  [";"] = true,
  [":"] = true,
  [","] = true,
  ["."] = true,
}

--- Check if a character can be jumped over
---@param char string Character to check
---@return boolean True if character can be jumped
local function is_jumpable(char)
  return JUMP_CHARS[char] ~= nil
end

--- Performs the smart tab jump
---@return boolean True if jumped, false otherwise
function M.try_jump()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]

  -- Get the character at the current cursor position
  local char_at_cursor = line:sub(col + 1, col + 1)

  -- If the character at cursor is jumpable, jump over it
  if is_jumpable(char_at_cursor) then
    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], col + 1 })
    return true
  end

  return false
end

----- Setup the smart tab jumper (legacy support, not needed with cmp integration)
function M.setup() end

return M
