--- Telescope "Find Anything" — a unified picker experience
---
--- Start with frecency (smart file finding), then switch sources on the fly:
---   <C-g>  → live_grep (search file contents)
---   <C-b>  → open buffers
---   <C-o>  → recent files (oldfiles)
---   <C-h>  → help tags
---   <C-r>  → resume (last picker)
---
--- Each switch carries your current query forward so you never need to retype!

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")

--- Get the current query text from the active picker.
---@param prompt_bufnr number
---@return string
local function get_query(prompt_bufnr)
  return action_state.get_current_picker(prompt_bufnr):_get_prompt() or ""
end

--- Close the current picker and open a new one, passing the query forward.
---@param prompt_bufnr number
---@param picker_fn function  telescope builtin function (e.g. builtin.live_grep)
local function switch_to(prompt_bufnr, picker_fn)
  local query = get_query(prompt_bufnr)
  actions.close(prompt_bufnr)
  vim.schedule(function()
    picker_fn({ default_text = query })
  end)
end

--- Attach source-switching mappings to any picker.
--- Pass this as the `attach_mappings` option.
---@param _prompt_bufnr number
---@param map function
---@return boolean
local function attach_switchers(_, map)
  map("i", "<C-g>", function(pb)
    switch_to(pb, builtin.live_grep)
  end, { desc = "Switch to grep" })

  map("i", "<C-b>", function(pb)
    switch_to(pb, builtin.buffers)
  end, { desc = "Switch to buffers" })

  map("i", "<C-o>", function(pb)
    switch_to(pb, builtin.oldfiles)
  end, { desc = "Switch to recent files" })

  map("i", "<C-h>", function(pb)
    switch_to(pb, builtin.help_tags)
  end, { desc = "Switch to help tags" })

  map("i", "<C-r>", function(pb)
    switch_to(pb, builtin.resume)
  end, { desc = "Resume last picker" })

  return true -- keep default mappings
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Entry points
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Find anything! Starts with find_files, then switch sources on the fly.
local function find_anything()
  builtin.find_files({
    attach_mappings = attach_switchers,
  })
end

--- Find anything starting with live_grep.
local function find_anything_grep()
  builtin.live_grep({
    attach_mappings = attach_switchers,
  })
end

--- Find anything starting with frecency (smart history) if the extension is loaded.
local function find_anything_frecency()
  local has_frecency = pcall(require, "telescope._extensions.frecency")
  if has_frecency then
    require("telescope").extensions.frecency.frecency({
      attach_mappings = attach_switchers,
    })
  else
    find_anything()
  end
end

return {
  find_anything = find_anything,
  find_anything_grep = find_anything_grep,
  find_anything_frecency = find_anything_frecency,
}
