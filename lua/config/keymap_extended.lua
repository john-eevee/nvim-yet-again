-- ╔══════════════════════════════════════════════════════════════╗
-- ║         EXTENDED KEYMAPS & PRODUCTIVITY SHORTCUTS             ║
-- ║    Additional mappings for common operations and workflows    ║
-- ╚══════════════════════════════════════════════════════════════╝

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SEARCH & REPLACE (Space + s)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Note: Telescope search keymaps in telescope.lua

keymap("n", "<leader>sw", function()
  local word = vim.fn.expand("<cword>")
  require("telescope.builtin").live_grep({ default_text = word })
end, { desc = "Search: Word under cursor" })

keymap("n", "<leader>st", "<cmd>Telescope<CR>", { desc = "Search: Telescope" })

-- Project search and replace (using quickfix)
keymap("n", "<leader>sr", function()
  vim.ui.input({ prompt = "Replace pattern: " }, function(pattern)
    if not pattern then
      return
    end
    vim.ui.input({ prompt = "With: " }, function(replacement)
      if not replacement then
        return
      end
      local cmd = "cfdo %s/" .. pattern .. "/" .. replacement .. "/gc | update"
      require("utils.logger").info("Search: After grep, run: :cfdo %s/" .. pattern .. "/" .. replacement .. "/gc | update")
    end)
  end)
end, { desc = "Search: Replace in project" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- DEBUG/RUN (Space + d) - Ready for extending with debuggers
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Run current file based on type
keymap("n", "<leader>dr", function()
  local ft = vim.bo.filetype
  local commands = {
    python = "!python3 %",
    lua = "!lua %",
    sh = "!bash %",
    javascript = "!node %",
  }

  if commands[ft] then
    vim.cmd(commands[ft])
  else
    require("utils.logger").warn("Run command not configured for " .. ft)
  end
end, { desc = "Debug: Run file" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- CODE FOLDING
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

keymap("n", "<leader>zz", "zz", { desc = "Fold: Center cursor" })
keymap("n", "<leader>zm", "zm", { desc = "Fold: More" })
keymap("n", "<leader>zr", "zr", { desc = "Fold: Reduce" })
keymap("n", "<leader>zM", "zM", { desc = "Fold: Close all" })
keymap("n", "<leader>zR", "zR", { desc = "Fold: Open all" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- QUICKFIX & LOCATION LIST
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

keymap("n", "<leader>xo", "<cmd>copen<CR>", { desc = "Quickfix: Open" })
keymap("n", "<leader>xc", "<cmd>cclose<CR>", { desc = "Quickfix: Close" })
keymap("n", "<leader>xx", "<cmd>cclose<CR>", { desc = "Quickfix: Toggle" })
keymap("n", "]q", "<cmd>cnext<CR>", { desc = "Quickfix: Next" })
keymap("n", "[q", "<cmd>cprevious<CR>", { desc = "Quickfix: Previous" })

keymap("n", "<leader>lo", "<cmd>lopen<CR>", { desc = "Location: Open" })
keymap("n", "<leader>lc", "<cmd>lclose<CR>", { desc = "Location: Close" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- REGISTERS & CLIPBOARD
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

keymap("n", "<leader>yr", "<cmd>Telescope registers<CR>", { desc = "Yank: Show registers" })

-- Clipboard management
if vim.fn.has("mac") == 1 then
  -- macOS
  keymap("n", "<leader>yy", '"+y', { desc = "Yank: To system clipboard" })
  keymap("v", "<leader>yy", '"+y', { desc = "Yank: To system clipboard" })
else
  -- Linux
  keymap("n", "<leader>yy", '"+y', { desc = "Yank: To system clipboard" })
  keymap("v", "<leader>yy", '"+y', { desc = "Yank: To system clipboard" })
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MARKS & JUMPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

keymap("n", "<leader>m", "<cmd>Telescope marks<CR>", { desc = "Marks: Show all" })
keymap("n", "m,", "m,", { desc = "Marks: Set mark at ," })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TERMINAL INTEGRATION
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Open terminal in split
keymap("n", "<leader>ts", function()
  vim.cmd("belowright split | terminal")
end, { desc = "Terminal: Horizontal split" })

keymap("n", "<leader>tv", function()
  vim.cmd("rightbelow vsplit | terminal")
end, { desc = "Terminal: Vertical split" })

keymap("n", "<leader>tt", function()
  vim.cmd("rightbelow split | resize 15 | terminal")
end, { desc = "Terminal: Floating" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- UNDO/REDO TREE (prepare for undotree plugin)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

keymap("n", "<leader>hu", "u", { desc = "Undo" })
keymap("n", "<leader>hr", "<C-r>", { desc = "Redo" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- JUMP TO DEFINITION (improve with Telescope)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

keymap("n", "<leader>jd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Jump: To definition" })
keymap("n", "<leader>jr", "<cmd>Telescope lsp_references<CR>", { desc = "Jump: To references" })
keymap("n", "<leader>ji", "<cmd>Telescope lsp_implementations<CR>", { desc = "Jump: To implementation" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- COLORSCHEME QUICK SWITCH
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

keymap("n", "<leader>uc", function()
  vim.ui.select(
    { "catppuccin", "default", "desert" },
    { prompt = "Choose colorscheme: " },
    function(choice)
      if choice then
        vim.cmd("colorscheme " .. choice)
      end
    end
  )
end, { desc = "UI: Change colorscheme" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SAVE & QUIT VARIATIONS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

keymap("n", "<leader>fw", "<cmd>w<CR>", { desc = "File: Write" })
keymap("n", "<leader>fW", "<cmd>wa<CR>", { desc = "File: Write all" })
keymap("n", "<leader>fx", "<cmd>wq<CR>", { desc = "File: Write and quit" })
