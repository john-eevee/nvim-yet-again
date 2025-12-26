-- ╔══════════════════════════════════════════════════════════════╗
-- ║            FISH SHELL INTEGRATION                            ║
-- ║    Configure Neovim to work seamlessly with FISH shell        ║
-- ╚══════════════════════════════════════════════════════════════╝

-- Use FISH as the default shell
vim.o.shell = "fish"
vim.o.shellcmdflag = "-ic"
vim.o.shelltemp = false

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TERMINAL MODE ENHANCEMENTS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Set up autocommand for terminal mode
local shell_group = vim.api.nvim_create_augroup("ShellIntegration", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = shell_group,
  callback = function()
    -- Disable number and relative numbers in terminal
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    -- Start in insert mode
    vim.cmd("startinsert")
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TERMINAL KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Exit terminal mode with Escape
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

-- Navigate from terminal with Ctrl+hjkl (to avoid interfering with shell shortcuts)
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)
