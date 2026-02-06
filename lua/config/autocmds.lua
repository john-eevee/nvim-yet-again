-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SUPPRESS LSP DEPRECATION WARNINGS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    format = function(diagnostic)
      -- Filter out deprecation warnings from LSP
      if diagnostic.severity == vim.diagnostic.severity.WARN and
         (diagnostic.message:lower():match("deprecat") or 
          diagnostic.message:lower():match("deprecated")) then
        return "" -- Return empty to hide deprecation warnings
      end
      return string.format(" %s", diagnostic.message)
    end,
  },
})

-- Suppress deprecation warnings in LSP diagnostics globally
local orig_open_float = vim.diagnostic.open_float
vim.diagnostic.open_float = function(opts)
  opts = opts or {}
  local diags = vim.diagnostic.get(opts.bufnr)
  local filtered_diags = vim.tbl_filter(function(d)
    local is_deprecation = d.severity == vim.diagnostic.severity.WARN and
      (d.message:lower():match("deprecat") or d.message:lower():match("deprecated"))
    return not is_deprecation
  end, diags)
  if #filtered_diags == 0 then return end
  return orig_open_float(opts)
end
