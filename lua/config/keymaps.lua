local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- BETTER DEFAULTS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Clear search highlights with Esc (normal mode only)
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Center cursor after navigation
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "<C-d>", "<C-d>zz", opts)

-- Quick escape from insert mode
map("i", "jk", "<Esc>", opts)
map("i", "jj", "<Esc>", opts)

-- Keep selection on indent
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move lines in visual mode
map("v", "J", ":move '>+1<CR>gv-gv", opts)
map("v", "K", ":move '<-2<CR>gv-gv", opts)

-- Preserve paste register
map("v", "p", '"_dP', opts)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- BUFFER NAVIGATION (IntelliJ-style)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Ctrl+Tab / Ctrl+Shift+Tab to cycle buffers (works in wezterm/kitty/alacritty)
map("n", "<C-Tab>", "<Cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<C-S-Tab>", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Alt+h/l for next/prev buffer (terminal-safe fallback)
map("n", "<A-l>", "<Cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<A-h>", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Jump through recent change locations (like Ctrl+Backspace in IntelliJ)
map("n", "g;", "g;zz", { desc = "Previous change location" })
map("n", "g,", "g,zz", { desc = "Next change location" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LEADER KEYBINDS (Space)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- File finding — unified "find anything" picker with source switching
map("n", "<leader>ff", function() require("config.find-anything").find_anything() end, { desc = "Find anything" })
map("n", "<leader>fg", function() require("config.find-anything").find_anything_grep() end, { desc = "Grep anything" })
map("n", "<leader>fr", "<Cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "Open buffers" })

-- File operations
map("n", "<leader>e", "<Cmd>Oil<CR>", { desc = "File explorer" })
map("n", "<leader>n", "<Cmd>enew<CR>", { desc = "New file" })

-- Buffer management
map("n", "<leader>bd", "<Cmd>bdelete<CR>", { desc = "Close buffer" })
map("n", "<leader>bD", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = "Close all others" })
map("n", "<leader>bA", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = "Close all buffers" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LSP
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

map("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map({ "n", "x" }, "<A-CR>", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- GIT
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

map("n", "<leader>gs", "<Cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
map("n", "<leader>gr", "<Cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map("n", "<leader>gb", "<Cmd>Gitsigns blame_line<CR>", { desc = "Blame line" })
map("n", "<leader>gp", "<Cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
map("n", "]h", "<Cmd>Gitsigns next_hunk<CR>", { desc = "Next hunk" })
map("n", "[h", "<Cmd>Gitsigns prev_hunk<CR>", { desc = "Previous hunk" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- QUICKFIX / DIAGNOSTICS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

map("n", "<leader>q", "<Cmd>copen<CR>", { desc = "Quickfix list" })
map("n", "]q", "<Cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "[q", "<Cmd>cprev<CR>", { desc = "Previous quickfix" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SEARCH & REPLACE
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

map({ "n", "v" }, "<leader>sr", function()
  local grug = require("grug-far")
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  grug.open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and ("*." .. ext) or nil,
    },
  })
end, { desc = "Search & replace" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- DB / SQL
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

map("n", "<leader>db", "<Cmd>DBUIToggle<CR>", { desc = "DB UI" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- COMMAND ABBREVIATIONS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Q q")
vim.cmd("cnoreabbrev Qa qa")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev QA qa")
vim.cmd("cnoreabbrev q1 q!")
vim.cmd("cnoreabbrev w1 w!")
