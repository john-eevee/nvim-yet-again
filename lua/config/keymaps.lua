local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = "\\"
vim.g.maplocalleader = " "

-- Utils

keymap("n", "<Up>", "k", opts)
keymap("n", "<Down>", "j", opts)
keymap("n", "<Left>", "h", opts)
keymap("n", "<Right>", "l", opts)

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

keymap("i", "jj", "<Esc>", opts)
keymap("i", "jk", "<Esc>", opts)

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "J", ":move '>+1<CR>gv-gv", opts)
keymap("v", "K", ":move '<-2<CR>gv-gv", opts)
keymap("v", "<C-Down>", ":move '>+1<CR>gv-gv", opts)
keymap("v", "<C-Up>", ":move '<-2<CR>gv-gv", opts)
keymap("v", "p", '"_dP', opts)

keymap("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
keymap("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })

vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Q q")
vim.cmd("cnoreabbrev Qa qa")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev QA qa")
vim.cmd("cnoreabbrev q1 q!")
vim.cmd("cnoreabbrev w1 w!")
keymap("n", "<A-F12>", function()
  require("snacks").terminal()
end, { desc = "Terminal: Toggle" })

vim.schedule(function()
  local wk = require("which-key")

  wk.add({
    {"<leader>a", group = "AI (Opencode)" },
    {"<leader>b" , { group = "Buffer" },
    {"<leader>c" , { group = "Code & LSP" },
    {"<leader>d" , { group = "Diagnostics" },
    {"<leader>D" , { group = "Debugging" },
    {"<leader>e" , { group = "Edit" },
    {"<leader>G" , { group = "Git" },
    {"<leader>g" , { group = "GoTo" },
    {"<leader>h" , { group = "Harpoon" },
    {"<leader>m" , { group = "Mise" },
    {"<leader>o" , { group = "Other" },
    {"<leader>s" , { group = "Search" },
    {"<leader>t" , { group = "Toggles" },
    {"<leader>x" , { group = "Trouble (Diagnostics)" },
    {"<leader>w" , { group = "Window" },
  })
end)
-- AI
keymap("n", "<leader>aa", function()
  require("opencode").ask("@this: ", { submit = true })
end, { desc = "AI: Ask opencode" })

keymap("n", "<leader>ax", function()
  require("opencode").select()
end, { desc = "AI: Execute opencode action" })

keymap("n", "<leader>at", function()
  require("opencode").toggle()
end, { desc = "AI: Toggle opencode" })

keymap("x", "<leader>aa", function()
  require("opencode").ask("@this: ", { submit = true })
end, { desc = "AI: Ask opencode" })

keymap("x", "<leader>ax", function()
  require("opencode").select()
end, { desc = "AI: Execute opencode action" })

keymap("n", "<leader>ar", function()
  return require("opencode").operator("@this ")
end, { desc = "AI: Add range to opencode", expr = true })

keymap("n", "<leader>al", function()
  return require("opencode").operator("@this ") .. "_"
end, { desc = "AI: Add line to opencode", expr = true })

-- Buffer

keymap("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Buffer: Previous" })
keymap("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Buffer: Next" })
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Buffer: Delete" })
keymap("n", "<leader>bl", "<cmd>ls<CR>", { desc = "Buffer: List" })
keymap("n", "<leader>bl", "<cmd>Telescope buffers<CR>", { desc = "Buffer: Picker" })
keymap("n", "<A-Left>", "<cmd>bprevious<cr>", { desc = "Buffer: Previous"})
keymap("n", "<A-Right>", "<cmd>bnext<cr>", { desc = "Buffer: Next"})
-- Edit

keymap("n", "<leader>ed", "yyp", { desc = "Edit: Duplicate line" })
keymap("v", "<leader>ed", "y'>p", { desc = "Edit: Duplicate selection" })
keymap("n", "<leader>ex", "dd", { desc = "Edit: Delete line" })
keymap("n", "<leader>ej", "J", { desc = "Edit: Join lines" })
keymap("n", "<leader>ec", "gcc", { desc = "Edit: Comment line" })
keymap("v", "<leader>ec", "gc", { desc = "Edit: Comment selection" })
keymap("n", "<leader>eg", "<cmd>", { desc = "Edit: Go to line" })

-- Search

keymap("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "Search: Find files" })
keymap("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "Search: Grep in files" })
keymap("n", "<leader>sh", "<cmd>Telescope highlights<CR>", { desc = "Search: Highlights" })
keymap("n", "<leader>sw", "<cmd>Telescope workspace_symbols<CR>", { desc = "Search: Workspace symbols" })
keymap("n", "<leader>st", "<cmd>Todo<CR>", { desc = "Search: Todos" })
keymap("n", "<leader>sx", "<cmd>Todo fixme<CR>", { desc = "Search: Fixmes" })

-- Toggles

keymap("n", "<leader>tr", function()
  vim.opt.relativenumber = not vim.opt.relativenumber._value
end, { desc = "Toggle: Relative numbers" })

keymap("n", "<leader>td", function()
  local enabled = vim.diagnostic.is_enabled()
  vim.diagnostic.enable(not enabled)
  vim.notify((not enabled and "Enabled" or "Disabled") .. " diagnostics", vim.log.levels.INFO)
end, { desc = "Toggle: Diagnostics" })

keymap("n", "<leader>tw", function()
  vim.opt.wrap = not vim.opt.wrap._value
  vim.notify((vim.opt.wrap._value and "Enabled" or "Disabled") .. " word wrap", vim.log.levels.INFO)
end, { desc = "Toggle: Word wrap" })

keymap("n", "<leader>ts", function()
  vim.opt.spell = not vim.opt.spell._value
  vim.notify((vim.opt.spell._value and "Enabled" or "Disabled") .. " spell check", vim.log.levels.INFO)
end, { desc = "Toggle: Spell check" })

keymap("n", "<leader>tt", function()
  require("snacks").terminal()
end, { desc = "Toggle: Terminal" })

-- Window Management

keymap("n", "<leader>wh", "<C-w>h", { desc = "Window: Left" })
keymap("n", "<leader>wj", "<C-w>j", { desc = "Window: Down" })
keymap("n", "<leader>wk", "<C-w>k", { desc = "Window: Up" })
keymap("n", "<leader>wl", "<C-w>l", { desc = "Window: Right" })
keymap("n", "<leader>wc", "<C-w>c", { desc = "Window: Close" })
keymap("n", "<leader>wv", "<C-w>v", { desc = "Window: Vertical split" })
keymap("n", "<leader>ws", "<C-w>s", { desc = "Window: Horizontal split" })
keymap("n", "<leader>wn", "<C-w>n", { desc = "Window: New window" })
keymap("n", "<leader>w=", "<C-w>=", { desc = "Window: Equalize sizes" })
keymap("n", "<leader>wz", function() require('zen-mode').toggle() end, {desc = "Window: Zen"})

-- Mise

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

keymap("n", "<leader>ms", run_mise_task, { desc = "Mise: Select task (ui.select)" })
keymap("n", "<leader>mt", "<cmd>MiseRunTelescope<CR>", { desc = "Mise: Telescope tasks" })

-- Other (file pair jump)

keymap("n", "<leader>oa", "<cmd>Other<cr>", { desc = "Other: Alternate file" })
keymap("n", "<leader>os", "<cmd>OtherSplit<cr>", { desc = "Other: Open in split" })
keymap("n", "<leader>ov", "<cmd>OtherVsplit<cr>", { desc = "Other: Open in vsplit" })


-- Trouble (Diagnostics)
keymap("<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)"})
keymap("<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
keymap("<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",{ desc = "Symbols (Trouble)" })
keymap("<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
keymap( "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
keymap( "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

