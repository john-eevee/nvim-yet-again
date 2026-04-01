local function map(mode, l, r, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, l, r, opts)
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LSP KEYMAPS (buffer-scoped on LspAttach)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
  callback = function(ev)
    local ts = require("telescope.builtin")

    map("n", "<C-b>", function()
      ts.lsp_definitions()
    end, "LSP: Goto Definition", { buffer = ev.buf })

    map("n", "<C-S-b>", function()
      ts.lsp_type_definitions()
    end, "LSP: Goto Declaration", { buffer = ev.buf })

    map("n", "<C-A-b>", function()
      ts.lsp_implementations()
    end, "LSP: Goto Implementation", { buffer = ev.buf })

    map("n", "<A-F7>", function()
      ts.lsp_references()
    end, "LSP: References", { buffer = ev.buf })

    map("n", "<C-k>", function()
      vim.lsp.buf.signature_help({ border = "single" })
    end, "LSP: Signature Help", { buffer = ev.buf })

    map("n", "<S-F6>", vim.lsp.buf.rename, "LSP: Rename", { buffer = ev.buf })
    map("n", "<C-A-f>", function()
      local ok, conform = pcall(require, "conform")
      if not ok then
        return
      end
      conform.format({ lsp_fallback = true })
    end, "LSP: Format", { buffer = ev.buf })
    map({ "n", "v" }, "<A-Enter>", function()
      vim.lsp.buf.code_action({ border = "single" })
    end, "LSP: Code Action", { buffer = ev.buf })

    map("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, "LSP: Format", { buffer = ev.buf })
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- FILETYPE KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FiletypeKeymaps", { clear = true }),
  pattern = "rust",
  callback = function()
    local rt = require("rust-tools")
    local opts = { noremap = true, silent = true }

    -- Rust-specific features not available via generic LSP
    -- Runnables (cargo run/test)
    map("n", "<C-A-u>r", rt.runnables.runnables, "Rust: Runnables", opts)
    -- Debug (LLDB)
    map("n", "<C-A-u>d", rt.debuggables.debuggables, "Rust: Debuggables", opts)
    -- Expand macro
    map("n", "<C-A-u>e", rt.expand_macro.expand_macro, "Rust: Expand macro", opts)
    -- Parent module
    map("n", "<C-A-u>p", rt.parent_module.parent_module, "Rust: Parent module", opts)
    -- Join lines
    map("n", "<C-A-u>j", function()
      rt.join_lines.join_lines()
    end, "Rust: Join lines", opts)
    -- Structural search replace
    map("n", "<C-A-u>s", rt.ssr.ssr, "Rust: SSR", opts)
  end,
})

-- Note: Java keymaps (jdtls) already use generic LSP bindings via LSP server
-- <leader>cr, <A-Enter> work for code actions
-- <leader>f for format
-- etc.

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- DIAGNOSTIC KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
map("n", "<F2>", vim.diagnostic.goto_next, "Goto Next Error", { noremap = true })
map("n", "<S-F2>", vim.diagnostic.goto_prev, "Goto Prev Error", { noremap = true })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- HARPOON KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.schedule(function()
  local harpoon = require("harpoon")

  map("n", "<C-A-m>a", function()
    harpoon:list():add()
  end, "Harpoon: Add file", { noremap = true })

  map("n", "<C-A-h>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, "Harpoon: Toggle menu", { noremap = true })

  map("n", "<C-1>", function()
    harpoon:list():select(1)
  end, "Harpoon: Jump to 1", { noremap = true })

  map("n", "<C-2>", function()
    harpoon:list():select(2)
  end, "Harpoon: Jump to 2", { noremap = true })

  map("n", "<C-3>", function()
    harpoon:list():select(3)
  end, "Harpoon: Jump to 3", { noremap = true })

  map("n", "<C-4>", function()
    harpoon:list():select(4)
  end, "Harpoon: Jump to 4", { noremap = true })

  map("n", "<C-A-h>p", function()
    harpoon:list():prev()
  end, "Harpoon: Previous", { noremap = true })

  map("n", "<C-A-h>n", function()
    harpoon:list():next()
  end, "Harpoon: Next", { noremap = true })
end)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- GITSIGNS KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup("GitsignsKeymaps", { clear = true }),
  callback = function()
    local gs = package.loaded.gitsigns
    if not gs then
      return
    end

    local buffer = vim.api.nvim_get_current_buf()
    local opts = { buffer = buffer }

    map("n", "]h", gs.next_hunk, "Next Hunk", opts)
    map("n", "[h", gs.prev_hunk, "Prev Hunk", opts)
    map({ "n", "v" }, "<C-A-g>s", ":Gitsigns stage_hunk<CR>", "Stage Hunk", opts)
    map({ "n", "v" }, "<C-A-z>", ":Gitsigns reset_hunk<CR>", "Reset Hunk", opts)
    map("n", "<C-A-g>S", gs.stage_buffer, "Stage Buffer", opts)
    map("n", "<C-A-g>u", gs.undo_stage_hunk, "Undo Stage Hunk", opts)
    map("n", "<C-A-g>R", gs.reset_buffer, "Reset Buffer", opts)
    map("n", "<C-A-g>p", gs.preview_hunk, "Preview Hunk", opts)
    map("n", "<C-A-g>b", function()
      gs.blame_line({ full = true })
    end, "Blame Line", opts)
    map("n", "<C-A-g>d", gs.diffthis, "Diff This", opts)
    map("n", "<C-A-g>D", function()
      gs.diffthis("~")
    end, "Diff This ~", opts)
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- OTHER.NVM KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
map("n", "<C-A-o>a", "<cmd>Other<cr>", "Open alternate file", { noremap = true })
map("n", "<C-A-o>s", "<cmd>OtherSplit<cr>", "Open alternate in split", { noremap = true })
map("n", "<C-A-o>v", "<cmd>OtherVsplit<cr>", "Open alternate in vsplit", { noremap = true })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- OPENCODE KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.schedule(function()
  map({ "n", "x" }, "<C-a>", function()
    require("opencode").ask("@this: ", { submit = true })
  end, "Ask opencode…")

  map({ "n", "x" }, "<C-x>", function()
    require("opencode").select()
  end, "Execute opencode action…")

  map({ "n", "t" }, "<C-.>", function()
    require("opencode").toggle()
  end, "Toggle opencode")

  map({ "n", "x" }, "go", function()
    return require("opencode").operator("@this ")
  end, "Add range to opencode", { expr = true })

  map("n", "goo", function()
    return require("opencode").operator("@this ") .. "_"
  end, "Add line to opencode", { expr = true })

  map("n", "<S-C-u>", function()
    require("opencode").command("session.half.page.up")
  end, "Scroll opencode up")

  map("n", "<S-C-d>", function()
    require("opencode").command("session.half.page.down")
  end, "Scroll opencode down")

  map("n", "+", "<C-a>", "Increment under cursor", { noremap = true })
  map("n", "-", "<C-x>", "Decrement under cursor", { noremap = true })
end)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MINI PLUGINS KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Mini.splitjoin
map("n", "gS", function()
  require("mini.splitjoin").toggle()
end, "Split/Join block", { noremap = true })
-- Mini.jump / Mini.jump2d (now using <C-A-j> since hjkl window nav removed)
map("n", "f", function()
  require("mini.jump2d").jump()
end, "Jump to char", { noremap = true })
map("n", "F", function()
  require("mini.jump2d").jump({ direction = "backward" })
end, "Jump backward", { noremap = true })
map("n", "<C-A-j>", function()
  require("mini.jump2d").start()
end, "Jump2d start", { noremap = true })

-- Mini.diff
map("n", "<C-A-x>", function()
  require("mini.diff").toggle_overlay()
end, "Diff toggle", { noremap = true })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- WHICH-KEY INTEGRATIONS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.schedule(function()
  local wk = require("which-key")

  -- Rust tools group
  wk.add({
    { "<C-A-u>r", desc = "Runnables" },
    { "<C-A-u>d", desc = "Debuggables" },
    { "<C-A-u>e", desc = "Expand Macro" },
    { "<C-A-u>p", desc = "Parent Module" },
    { "<C-A-u>j", desc = "Join Lines" },
    { "<C-A-u>s", desc = "SSR" },
  })

  -- Harpoon subcommands
  wk.add({
    { "<C-A-h>p", desc = "Harpoon: Previous" },
    { "<C-A-h>n", desc = "Harpoon: Next" },
  })

  -- Gitsigns subcommands
  wk.add({
    { "<C-A-g>S", desc = "Stage Buffer" },
    { "<C-A-g>u", desc = "Undo Stage Hunk" },
    { "<C-A-g>R", desc = "Reset Buffer" },
    { "<C-A-g>D", desc = "Diff This ~" },
  })

  -- Other.nvim subcommands
  wk.add({
    { "<C-A-o>a", desc = "Open Alternate" },
    { "<C-A-o>s", desc = "Open in Split" },
    { "<C-A-o>v", desc = "Open in Vsplit" },
  })

  -- Telescope/Search subcommands
  wk.add({
    { "<C-A-c>h", desc = "Highlights" },
    { "<C-A-c>w", desc = "Workspace Symbols" },
  })

  -- Test/Todo subcommands
  wk.add({
    { "<C-A-t>d", desc = "Todo Search" },
    { "<C-A-t>f", desc = "Todo/Fix/Fixme" },
  })

  -- Mise task subcommands
  wk.add({
    { "<C-A-m>r", desc = "Run Mise Task (ui.select)" },
    { "<C-A-m>R", desc = "Run Mise Task (telescope)" },
  })

  -- Format/LSP (moved from C-A-l to C-A-f for window nav)
  wk.add({
    { "<C-A-f>", desc = "Format" },
  })

  -- Split/Session
  wk.add({
    { "<C-A-s>y", desc = "Summary Toggle" },
    { "<C-A-s>t", desc = "Stop Test" },
    { "<C-A-s>e", desc = "Session" },
  })

  -- Utils (moved DAP UI from C-A-u>d to C-A-d>u to avoid Rust Debuggables collision)
  wk.add({
    { "<C-A-d>u", desc = "DAP UI" },
    { "<C-A-e>r", desc = "REPL Toggle" },
  })

  -- Database
  wk.add({
    { "<C-A-d>b", desc = "Toggle DB UI" },
  })
end)
