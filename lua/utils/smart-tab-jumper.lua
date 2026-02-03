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

--- Create Tab mapping for cmp integration
---@param cmp table The nvim-cmp module
---@param luasnip table The luasnip module
---@return table The Tab mapping configuration for cmp
function M.create_cmp_mapping(cmp, luasnip)
  return cmp.mapping(function(fallback)
    -- Try smart tab jump first
    if M.try_jump() then
      return
    end
    
    -- Then handle cmp menu
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.locally_jumpable(1) then
      luasnip.jump(1)
    else
      fallback()
      -- If fallback triggered the completion, auto-select the first item
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      end
    end
  end, { "i", "s" })
end

--- Create Shift+Tab mapping for cmp integration
---@param cmp table The nvim-cmp module
---@param luasnip table The luasnip module
---@return table The Shift+Tab mapping configuration for cmp
function M.create_shift_tab_mapping(cmp, luasnip)
  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.locally_jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" })
end

--- Setup the smart tab jumper (legacy support, not needed with cmp integration)
function M.setup()
  vim.notify("Smart Tab Jumper initialized! (Use cmp integration for best results)", vim.log.levels.INFO)
end

return M
