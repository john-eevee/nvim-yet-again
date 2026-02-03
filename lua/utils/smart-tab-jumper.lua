-- Smart Tab Jumper Utility
-- Jumps over closing brackets/quotes when Tab is pressed in insert mode
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

--- Performs the smart tab jump or regular tab insertion
---@return string The keys to execute
function M.smart_tab()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  
  -- Get the character at the current cursor position
  local char_at_cursor = line:sub(col + 1, col + 1)
  
  -- If the character at cursor is jumpable, jump over it
  if is_jumpable(char_at_cursor) then
    return "<Right>"
  end
  
  -- Otherwise, insert a regular tab
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end

--- Setup the smart tab jumper
function M.setup()
  local opts = { noremap = true, silent = true, expr = true }
  
  -- Map Tab key in insert mode
  vim.keymap.set("i", "<Tab>", function()
    return M.smart_tab()
  end, opts)
  
  vim.notify("Smart Tab Jumper enabled!", vim.log.levels.INFO)
end

return M
