-- ╔══════════════════════════════════════════════════════════════╗
-- ║         CORE KEYMAPS - MNEMONIC LEADER-BASED BINDINGS         ║
-- ║    Well-organized key mappings following mnemonic patterns     ║
-- ╚══════════════════════════════════════════════════════════════╝

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
-- Disable arrow keys for pure hjkl navigation
keymap("n", "<Up>", "<nop>", opts)
keymap("n", "<Down>", "<nop>", opts)
keymap("n", "<Left>", "<nop>", opts)
keymap("n", "<Right>", "<nop>", opts)

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

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- FILE OPERATIONS (Space + f)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
keymap("n", "<leader>fs", "<cmd>write<CR>", { desc = "File: Save" })
keymap("n", "<leader>fS", "<cmd>wall<CR>", { desc = "File: Save all" })
keymap("n", "<leader>fe", "<cmd>edit<CR>", { desc = "File: Reload" })
keymap("n", "<leader>fq", "<cmd>quit<CR>", { desc = "File: Quit" })
keymap("n", "<leader>fQ", "<cmd>quit!<CR>", { desc = "File: Quit without save" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- FILE EXPLORER (Space + -)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
keymap("n", "<leader>-", "<cmd>Oil<CR>", { desc = "Explorer: Oil" })

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
  if vim.opt.spell._value then
    require("utils.logger").info("Spell check: ON")
  else
    require("utils.logger").info("Spell check: OFF")
  end
end, { desc = "UI: Toggle spell check" })

-- Toggle diagnostics
keymap("n", "<leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_disabled())
  if vim.diagnostic.is_disabled() then
    require("utils.logger").info("Diagnostics: OFF")
  else
    require("utils.logger").info("Diagnostics: ON")
  end
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
