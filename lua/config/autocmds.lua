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
      if
        diagnostic.severity == vim.diagnostic.severity.WARN
        and (diagnostic.message:lower():match("deprecat") or diagnostic.message:lower():match("deprecated"))
      then
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
    local is_deprecation = d.severity == vim.diagnostic.severity.WARN
      and (d.message:lower():match("deprecat") or d.message:lower():match("deprecated"))
    return not is_deprecation
  end, diags)
  if #filtered_diags == 0 then
    return
  end
  return orig_open_float(opts)
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- AUTO RELOAD FILES ON DISK CHANGE
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.opt.autoread = true

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})
vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("FloatDiagnostic", { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
  end,
})
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("TerminalBehavior", { clear = true }),
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    local ok, conform = pcall(require, 'conform')
    if not ok then
      return
    end
    conform.format({bufnr = args.buf})
  end
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- CONFIRM QUIT ON LAST WINDOW
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    if vim.fn.has("gui_running") == 0 and #vim.api.nvim_list_uis() == 0 then
      return
    end

    local tabpages = vim.api.nvim_list_tabpages()
    if #tabpages > 1 then
      return
    end

    local wins = vim.api.nvim_tabpage_list_wins(tabpages[1])
    if #wins > 1 then
      return
    end

    local buf = vim.api.nvim_win_get_buf(wins[1])
    local modified = vim.api.nvim_buf_get_option(buf, "modified")

    if modified or vim.bo[buf].modified then
      return
    end

    local confirm = vim.fn.confirm("Quit nvim?", "&Yes\n&No", 2, "Q")
    if confirm ~= 1 then
      vim.cmd("qa!")
    end
  end,
})
