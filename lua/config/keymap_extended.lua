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
      require("utils.logger").info("Search: After grep, run: :cfdo %s/" ..
      pattern .. "/" .. replacement .. "/gc | update")
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
keymap("n", "<leader>yy", '"+y', { desc = "Yank: To system clipboard" })
keymap("v", "<leader>yy", '"+y', { desc = "Yank: To system clipboard" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MARKS & JUMPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

keymap("n", "<leader>m", "<cmd>Telescope marks<CR>", { desc = "Marks: Show all" })
keymap("n", "m,", "m,", { desc = "Marks: Set mark at ," })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TERMINAL INTEGRATION (Space + t)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Open terminal in split (horizontal)
keymap("n", "<leader>th", function()
  vim.cmd("belowright split | terminal")
end, { desc = "Terminal: Horizontal split" })

keymap("n", "<leader>tv", function()
  vim.cmd("rightbelow vsplit | terminal")
end, { desc = "Terminal: Vertical split" })

keymap("n", "<leader>tf", function()
  vim.cmd("rightbelow split | resize 15 | terminal")
end, { desc = "Terminal: Floating (small)" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- GIT INTEGRATION (Space + g) - vim-fugitive
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

keymap("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git: Status" })
keymap("n", "<leader>ga", "<cmd>Git add %<CR>", { desc = "Git: Add file" })
keymap("n", "<leader>gA", "<cmd>Git add .<CR>", { desc = "Git: Add all" })
keymap("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git: Commit" })
keymap("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git: Push" })
keymap("n", "<leader>gP", "<cmd>Git pull<CR>", { desc = "Git: Pull" })
keymap("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git: Blame" })
keymap("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "Git: Log" })
keymap("n", "<leader>gd", "<cmd>Git diff<CR>", { desc = "Git: Diff" })
keymap("n", "<leader>gB", "<cmd>GBrowse<CR>", { desc = "Git: Browse on web" })

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
-- DIAGNOSTICS NAVIGATION (Space + e)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

keymap("n", "]e", vim.diagnostic.goto_next, { desc = "Diagnostic: Next" })
keymap("n", "[e", vim.diagnostic.goto_prev, { desc = "Diagnostic: Previous" })
keymap("n", "<leader>ee", vim.diagnostic.open_float, { desc = "Diagnostic: Open float" })
keymap("n", "<leader>eq", vim.diagnostic.setloclist, { desc = "Diagnostic: Set loclist" })

-- Show all diagnostics for the project (Telescope)
keymap("n", "<leader>ea", function()
  local ok, telescope = pcall(require, "telescope")
  if not ok then
    require("utils.logger").error("Telescope not available")
    return
  end

  local has_diag_picker, _ = pcall(require, "telescope.builtin")
  if has_diag_picker then
    -- order diagnostics by severity: Error -> Warn -> Info -> Hint
    require("telescope.builtin").diagnostics({
      severity_sort = true,
      layout_strategy = "vertical",
      layout_config = { height = 0.6 },
    })
    return
  end
  -- Last fallback: populate quickfix and open
  local items = {}
  for _, d in ipairs(vim.diagnostic.get()) do
    table.insert(items, {
      bufnr = d.bufnr or 0,
      lnum = d.range and d.range.start and d.range.start.line + 1 or 1,
      col = d.range and d.range.start and d.range.start.character + 1 or 1,
      text = (d.message or "") .. " [" .. (d.source or "") .. "]",
    })
  end
  vim.fn.setqflist({}, "", { title = "Workspace Diagnostics", items = items })
  vim.cmd("copen")
end, { desc = "Diagnostic: Show all workspace diagnostics (Telescope)" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- CODE OPERATIONS (Space + c) - LSP actions
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

keymap("n", "<leader>cf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Code: Format" })
keymap("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Code: Rename" })
keymap("n", "<leader>ch", vim.lsp.buf.hover, { desc = "Code: Hover" })
keymap("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "Code: Signature help" })

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
