-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, silent = true, expr = true }

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LEADER KEY SETUP
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Leader is set in settings.lua as space

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- NAVIGATION IMPROVEMENTS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Arrow keys work alongside hjkl navigation
keymap("n", "<Up>", "k", opts)
keymap("n", "<Down>", "j", opts)
keymap("n", "<Left>", "h", opts)
keymap("n", "<Right>", "l", opts)

-- Center cursor on search results
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- Center on page up/down
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- WINDOW NAVIGATION & MANAGEMENT (Space + w)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Split navigation
keymap("n", "<leader>wh", "<C-w>h", { desc = "Window: Left" })
keymap("n", "<leader>wj", "<C-w>j", { desc = "Window: Down" })
keymap("n", "<leader>wk", "<C-w>k", { desc = "Window: Up" })
keymap("n", "<leader>wl", "<C-w>l", { desc = "Window: Right" })

-- Arrow key variants for navigation
keymap("n", "<leader>w<Left>", "<C-w>h", { desc = "Window: Left (arrow)" })
keymap("n", "<leader>w<Down>", "<C-w>j", { desc = "Window: Down (arrow)" })
keymap("n", "<leader>w<Up>", "<C-w>k", { desc = "Window: Up (arrow)" })
keymap("n", "<leader>w<Right>", "<C-w>l", { desc = "Window: Right (arrow)" })

-- Split creation (new splits go right/below)
keymap("n", "<leader>wv", "<C-w>v", { desc = "Window: Split vertical" })
keymap("n", "<leader>ws", "<C-w>s", { desc = "Window: Split horizontal" })
keymap("n", "<leader>wn", "<C-w>n", { desc = "Window: New window" })

-- Split manipulation
keymap("n", "<leader>wc", "<C-w>c", { desc = "Window: Close" })
keymap("n", "<leader>wo", "<C-w>o", { desc = "Window: Only" })
keymap("n", "<leader>w=", "<C-w>=", { desc = "Window: Equalize sizes" })

-- Resize windows
keymap("n", "<leader>w+", "<C-w>+", { desc = "Window: Increase height" })
keymap("n", "<leader>w-", "<C-w>-", { desc = "Window: Decrease height" })
keymap("n", "<leader>w>", "<C-w>>", { desc = "Window: Increase width" })
keymap("n", "<leader>w<", "<C-w><", { desc = "Window: Decrease width" })

-- Arrow key variants for resizing (Shift+arrow for height, Alt+arrow for width)
keymap("n", "<leader>w<S-Up>", "<C-w>+", { desc = "Window: Increase height (shift+up)" })
keymap("n", "<leader>w<S-Down>", "<C-w>-", { desc = "Window: Decrease height (shift+down)" })
keymap("n", "<leader>w<M-Right>", "<C-w>>", { desc = "Window: Increase width (alt+right)" })
keymap("n", "<leader>w<M-Left>", "<C-w><", { desc = "Window: Decrease width (alt+left)" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- BUFFER MANAGEMENT (Space + b)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
keymap("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Buffer: New" })
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Buffer: Delete" })
keymap("n", "<leader>bl", "<cmd>bnext<CR>", { desc = "Buffer: Next" })
keymap("n", "<leader>bh", "<cmd>bprevious<CR>", { desc = "Buffer: Previous" })
keymap("n", "<leader>ba", "<cmd>%bdelete|edit #<CR>", { desc = "Buffer: Delete all others" })

-- Smart buffer navigation with counts
keymap("n", "<C-l>", "<cmd>bnext<CR>", { desc = "Buffer: Next (Ctrl+l)" })
keymap("n", "<C-h>", "<cmd>bprevious<CR>", { desc = "Buffer: Previous (Ctrl+h)" })

-- Arrow key variants for buffer navigation
keymap("n", "<C-Right>", "<cmd>bnext<CR>", { desc = "Buffer: Next (ctrl+right)" })
keymap("n", "<C-Left>", "<cmd>bprevious<CR>", { desc = "Buffer: Previous (ctrl+left)" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- FILE OPERATIONS (Space + f)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
keymap("n", "<leader><leader>", "<cmd>write<CR>", { desc = "File: Save" })
keymap("n", "<leader>fs", "<cmd>write<CR>", { desc = "File: Save" })
keymap("n", "<leader>fS", "<cmd>wall<CR>", { desc = "File: Save all" })
keymap("n", "<leader>fe", "<cmd>edit<CR>", { desc = "File: Reload" })
keymap("n", "<leader>fq", "<cmd>quit<CR>", { desc = "File: Quit" })
keymap("n", "<leader>fQ", "<cmd>quit!<CR>", { desc = "File: Quit without save" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- FILE EXPLORER
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Note: <leader>- is handled by oil.nvim in lazy.lua

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SEARCH & REPLACE (Space + s)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
keymap("n", "<leader>sh", "<cmd>nohlsearch<CR>", { desc = "Search: Clear highlight" })
-- Additional search/replace mappings will be added with Telescope integration

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MODE TRANSITIONS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Escape alternatives
keymap("i", "jj", "<Esc>", opts)
keymap("i", "jk", "<Esc>", opts)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- VISUAL MODE ENHANCEMENTS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Indent in visual mode (stay in visual)
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move lines in visual mode
keymap("v", "J", ":move '>+1<CR>gv-gv", opts)
keymap("v", "K", ":move '<-2<CR>gv-gv", opts)

-- Arrow key variants for line movement
keymap("v", "<C-Down>", ":move '>+1<CR>gv-gv", opts)
keymap("v", "<C-Up>", ":move '<-2<CR>gv-gv", opts)

-- Keep register when pasting
keymap("v", "p", '"_dP', opts)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MISC UTILITIES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Clear search highlight on pressing Escape
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Toggle relative number
keymap("n", "<leader>ur", function()
  vim.opt.relativenumber = not vim.opt.relativenumber._value
end, { desc = "UI: Toggle relative numbers" })

-- Toggle line wrapping
keymap("n", "<leader>uw", function()
  vim.opt.wrap = not vim.opt.wrap._value
end, { desc = "UI: Toggle line wrap" })

-- Toggle spell checking
keymap("n", "<leader>us", function()
  vim.opt.spell = not vim.opt.spell._value
end, { desc = "UI: Toggle spell check" })

-- Toggle diagnostics
keymap("n", "<leader>ud", function()
  local enabled = vim.diagnostic.is_enabled()
  vim.diagnostic.enable(not enabled)
end, { desc = "UI: Toggle diagnostics" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- COMMAND ABBREVIATIONS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Save shortcuts
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Q q")
vim.cmd("cnoreabbrev Qa qa")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev QA qa")

-- Common typos
vim.cmd("cnoreabbrev q1 q!")
vim.cmd("cnoreabbrev w1 w!")
