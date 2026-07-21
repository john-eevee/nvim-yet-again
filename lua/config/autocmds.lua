-- Auto-reload files changed on disk
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "FocusGained" }, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

-- Float diagnostics on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("FloatDiagnostic", { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
  end,
})

-- Auto-start insert in terminal buffers
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("TerminalBehavior", { clear = true }),
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})
