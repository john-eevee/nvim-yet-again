-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, silent = true, expr = true }

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SMART TAB JUMPER
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Smart Tab Jumper is integrated with cmp in lua/plugins/cmp.lua
-- No additional setup needed here

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- NAVIGATION IMPROVEMENTS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Arrow keys work alongside hjkl navigation
keymap("n", "<Up>", "k", opts)
keymap("n", "<Down>", "j", opts)
keymap("n", "<Left>", "h", opts)
keymap("n", "<Right>", "l", opts)

-- Colemak-DH home-row navigation remap
-- Map Colemak-DH keys to Vim's hjkl so movement remains ergonomic on that layout.
-- s => h (left), n => j (down), e => k (up), i => l (right)
-- (Colemak-DH remaps removed) Using arrow keys for navigation per user request

-- Center cursor on search results
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- Center on page up/down
keymap("n", "<C-u>", "<C-u>zz", opts)
-- Note: <C-d> is remapped to duplicate line (IntelliJ style) below

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- WINDOW NAVIGATION & MANAGEMENT
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Split navigation (IntelliJ-style: Ctrl+Alt+Arrow keys only)
-- Using arrows to avoid collisions with plugins (Harpoon, LSP Format, Mini.jump2d)

-- Arrow key variants for navigation (IntelliJ-style)
keymap("n", "<C-A-Left>", "<C-w>h", { desc = "Window: Left" })
keymap("n", "<C-A-Down>", "<C-w>j", { desc = "Window: Down" })
keymap("n", "<C-A-Up>", "<C-w>k", { desc = "Window: Up" })
keymap("n", "<C-A-Right>", "<C-w>l", { desc = "Window: Right" })

-- Split manipulation (Ctrl+F4 for close, similar to IntelliJ)
keymap("n", "<C-F4>", "<C-w>c", { desc = "Window: Close (IntelliJ-style)" })
keymap("n", "<C-A-v>", "<C-w>v", { desc = "Window: Split vertical" })
keymap("n", "<C-A-s>", "<C-w>s", { desc = "Window: Split horizontal" })
keymap("n", "<C-A-n>", "<C-w>n", { desc = "Window: New window" })
keymap("n", "<C-A-=>", "<C-w>=", { desc = "Window: Equalize sizes" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- BUFFER MANAGEMENT
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Buffer navigation (IntelliJ-style: Alt+Left/Right)
keymap("n", "<A-Left>", "<cmd>bprevious<CR>", { desc = "Buffer: Previous (IntelliJ)" })
keymap("n", "<A-Right>", "<cmd>bnext<CR>", { desc = "Buffer: Next (IntelliJ)" })

-- Legacy control binds still available
keymap("n", "<C-h>", "<cmd>bprevious<CR>", { desc = "Buffer: Previous (Ctrl+h)" })
keymap("n", "<C-l>", "<cmd>bnext<CR>", { desc = "Buffer: Next (Ctrl+l)" })


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- FILE EXPLORER
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Note: <leader>- is handled by oil.nvim in lazy.lua
-- Note: <M-1> is handled by nvim-tree.lua in lua/plugins/nvim-tree.lua

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SEARCH & REPLACE
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

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

-- Duplicate line (IntelliJ: Ctrl+D)
keymap("n", "<C-d>", "yyp", { desc = "Edit: Duplicate line" })
keymap("v", "<C-d>", "y'>p", { desc = "Edit: Duplicate selection" })

-- Delete line (IntelliJ: Ctrl+Y)
keymap("n", "<C-y>", "dd", { desc = "Edit: Delete line" })

-- Join lines (IntelliJ: Ctrl+Shift+J)
keymap("n", "<C-S-j>", "J", { desc = "Edit: Join lines" })

-- Comment line (IntelliJ: Ctrl+/)
-- Delegated to mini.comment or native gc; users can map <C-/> to "gcc" if desired
-- Note: Ctrl+/ may require terminal-specific key handling; map to gc for now
keymap("n", "<C-/>", "gcc", { desc = "Edit: Comment line" })
keymap("v", "<C-/>", "gc", { desc = "Edit: Comment selection" })

-- Go to Line (IntelliJ: Ctrl+G)
keymap("n", "<C-g>", "<cmd>Telescope goto_line<CR>", { desc = "Navigate: Go to line" })

-- Toggle relative number
keymap("n", "<C-A-r>", function()
  vim.opt.relativenumber = not vim.opt.relativenumber._value
end, { desc = "UI: Toggle relative numbers" })

-- Toggle diagnostics (moved under <C-A-d> as a group)
keymap("n", "<C-A-d>d", function()
  local enabled = vim.diagnostic.is_enabled()
  vim.diagnostic.enable(not enabled)
end, { desc = "UI: Toggle diagnostics" })

-- Toggle line wrapping (moved under <C-A-w> for window group)
keymap("n", "<C-A-w>w", function()
  vim.opt.wrap = not vim.opt.wrap._value
end, { desc = "UI: Toggle line wrap" })

-- Toggle spell checking (moved under <C-A-p> for clarity, away from DAP Pause on base <C-A-p>)
keymap("n", "<C-A-d>s", function()
  vim.opt.spell = not vim.opt.spell._value
end, { desc = "UI: Toggle spell check" })

-- Show Terminal (IntelliJ: Alt+F12)
keymap("n", "<A-F12>", function()
  require("snacks").terminal()
end, { desc = "Terminal: Toggle" })

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

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MISE TASKS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local function run_mise_task()
  local task_list = vim.fn.systemlist("mise tasks --json 2>/dev/null")
  if vim.v.shell_error ~= 0 or #task_list == 0 then
    vim.notify("No mise tasks found", vim.log.levels.WARN)
    return
  end

  local tasks = {}
  for _, line in ipairs(task_list) do
    local decoded = vim.json.decode(line)
    if decoded and decoded.name then
      table.insert(tasks, decoded)
    end
  end

  vim.ui.select(tasks, {
    prompt = "Select mise task:",
    format_item = function(item)
      return item.name .. (item.description and (" - " .. item.description) or "")
    end,
  }, function(selected)
    if not selected then
      return
    end

    vim.ui.input({ prompt = "Arguments (optional): " }, function(args)
      local args_str = args and args ~= "" and (" " .. args) or ""
      local title = string.format("[mise] %s%s", selected.name, args_str)
      local cwd = vim.fn.getcwd()

      local cmd = string.format("wezterm cli spawn --cwd '%s' -- bash -c 'mise run %s%s'", cwd, selected.name, args_str)
      local pane_id = vim.fn.system(cmd):gsub("%s+", "")

      if pane_id and pane_id ~= "" then
        vim.fn.system(string.format("wezterm cli set-tab-title --pane-id %s '%s'", pane_id, title))
      end
    end)
  end)
end

vim.api.nvim_create_user_command("MiseRun", run_mise_task, { nargs = 0, desc = "Run mise task in tmux split" })
vim.api.nvim_create_user_command("MiseRunTelescope", function()
  vim.cmd("MiseRunTelescope")
end, { nargs = 0, desc = "Run mise task via telescope" })
keymap("n", "<C-A-m>r", run_mise_task, { desc = "Mise: Run task (ui.select)" })
keymap("n", "<C-A-m>R", "<cmd>MiseRunTelescope<CR>", { desc = "Mise: Run task (telescope)" })
