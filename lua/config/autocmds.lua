-- ╔══════════════════════════════════════════════════════════════╗
-- ║         AUTOCOMMANDS & EVENT HANDLERS                         ║
-- ║    Auto-execute actions on specific vim events                ║
-- ╚══════════════════════════════════════════════════════════════╝

-- Create autocommand groups
local group = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TEXT EDITING ENHANCEMENTS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local editing_group = group("TextEditing", { clear = true })

-- Trim trailing whitespace on save
autocmd("BufWritePre", {
  group = editing_group,
  pattern = "*",
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Return to last edit position on open
autocmd("BufReadPost", {
  group = editing_group,
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- FILE TYPE SPECIFIC SETTINGS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local filetype_group = group("FileTypeSettings", { clear = true })

-- 2 space indent for YAML, JSON, HTML
autocmd("FileType", {
  group = filetype_group,
  pattern = { "yaml", "json", "html", "css", "javascript", "typescript" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- HIGHLIGHT ON YANK
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local yank_group = group("YankHighlight", { clear = true })

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 200,
    })
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- RESIZE SPLITS ON WINDOW RESIZE
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local resize_group = group("ResizeSplits", { clear = true })

autocmd("VimResized", {
  group = resize_group,
  pattern = "*",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- FOCUSED WINDOW HIGHLIGHTING (subtle)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local focus_group = group("FocusedWindow", { clear = true })

-- Highlight current window's number column
autocmd({ "WinEnter", "WinLeave" }, {
  group = focus_group,
  pattern = "*",
  callback = function()
    if vim.api.nvim_get_mode().mode == "n" then
      vim.opt_local.cursorline = vim.fn.getcmdwintype() == ""
    end
  end,
})
