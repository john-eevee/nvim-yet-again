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

    map("n", "gD", function()
      ts.lsp_type_definitions()
    end, "LSP: Goto Declaration", { buffer = ev.buf })

    map("n", "gd", function()
      ts.lsp_definitions()
    end, "LSP: Goto Definition", { buffer = ev.buf })

    map("n", "K", function()
      vim.lsp.buf.hover({ border = "single" })
    end, "LSP: Hover", { buffer = ev.buf })

    map("n", "gi", function()
      ts.lsp_implementations()
    end, "LSP: Goto Implementation", { buffer = ev.buf })

    map("n", "<C-k>", function()
      vim.lsp.buf.signature_help({ border = "single" })
    end, "LSP: Signature Help", { buffer = ev.buf })

    map("n", "<leader>cr", vim.lsp.buf.rename, "LSP: Rename", { buffer = ev.buf })

    map({ "n", "v" }, "<A-Enter>", function()
      vim.lsp.buf.code_action({ border = "single" })
    end, "LSP: Code Action", { buffer = ev.buf })

    map("n", "gr", function()
      ts.lsp_references()
    end, "LSP: References", { buffer = ev.buf })

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

    map("n", "<leader>Rh", rt.hover_actions.hover_actions, "Rust: Hover actions", opts)
    map("n", "<leader>Ra", rt.code_action_group.code_action_group, "Rust: Code actions", opts)
    map("n", "<leader>Rd", rt.debuggables.debuggables, "Rust: Debuggables", opts)
    map("n", "<leader>Rr", rt.runnables.runnables, "Rust: Runnables", opts)
    map("n", "<leader>Rp", rt.parent_module.parent_module, "Rust: Parent module", opts)
    map("n", "<leader>Rj", function()
      rt.join_lines.join_lines()
    end, "Rust: Join lines", opts)
    map("n", "<leader>Re", rt.expand_macro.expand_macro, "Rust: Expand macro", opts)
    map("n", "<leader>RS", rt.ssr.ssr, "Rust: Structural search replace", opts)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FiletypeKeymaps", { clear = true }),
  pattern = "java",
  callback = function()
    local jdtls = require("jdtls")
    local opts = { noremap = true, silent = true }

    map("n", "<leader>jc", jdtls.compile, "Java: Compile", opts)
    map("n", "<leader>jC", jdtls.organize_imports, "Java: Organize imports", opts)
    map("n", "<leader>je", jdtls.extract_variable, "Java: Extract variable", opts)
    map("n", "<leader>jm", jdtls.extract_method, "Java: Extract method", opts)
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- HARPOON KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.schedule(function()
  local harpoon = require("harpoon")

  map("n", "<leader>ha", function()
    harpoon:list():add()
  end, "Harpoon: Add file", { noremap = true })

  map("n", "<leader>hm", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, "Harpoon: Toggle menu", { noremap = true })

  map("n", "<leader>h1", function()
    harpoon:list():select(1)
  end, "Harpoon: Jump to 1", { noremap = true })

  map("n", "<leader>h2", function()
    harpoon:list():select(2)
  end, "Harpoon: Jump to 2", { noremap = true })

  map("n", "<leader>h3", function()
    harpoon:list():select(3)
  end, "Harpoon: Jump to 3", { noremap = true })

  map("n", "<leader>h4", function()
    harpoon:list():select(4)
  end, "Harpoon: Jump to 4", { noremap = true })

  map("n", "<leader>hp", function()
    harpoon:list():prev()
  end, "Harpoon: Previous", { noremap = true })

  map("n", "<leader>hn", function()
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
    map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk", opts)
    map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk", opts)
    map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer", opts)
    map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk", opts)
    map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer", opts)
    map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk", opts)
    map("n", "<leader>ghb", function()
      gs.blame_line({ full = true })
    end, "Blame Line", opts)
    map("n", "<leader>ghd", gs.diffthis, "Diff This", opts)
    map("n", "<leader>ghD", function()
      gs.diffthis("~")
    end, "Diff This ~", opts)
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- OTHER.NVM KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
map("n", "<leader>oa", "<cmd>Other<cr>", "Open alternate file", { noremap = true })
map("n", "<leader>os", "<cmd>OtherSplit<cr>", "Open alternate in split", { noremap = true })
map("n", "<leader>ov", "<cmd>OtherVsplit<cr>", "Open alternate in vsplit", { noremap = true })

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

-- Mini.move - move lines/selection
map("n", "<M-j>", "<cmd>lua require('mini.move').move_down()<CR>", "Move line down", { noremap = true })
map("n", "<M-k>", "<cmd>lua require('mini.move').move_up()<CR>", "Move line up", { noremap = true })
map("v", "<M-j>", "<cmd>lua require('mini.move').move_down()<CR>", "Move selection down", { noremap = true })
map("v", "<M-k>", "<cmd>lua require('mini.move').move_up()<CR>", "Move selection up", { noremap = true })
map("v", "<M-h>", "<cmd>lua require('mini.move').move_left()<CR>", "Move selection left", { noremap = true })
map("v", "<M-l>", "<cmd>lua require('mini.move').move_right()<CR>", "Move selection right", { noremap = true })

-- Mini.splitjoin
map("n", "gS", function()
  require("mini.splitjoin").toggle()
end, "Split/Join block", { noremap = true })

-- Mini.splitjoin
map("n", "gS", function()
  require("mini.splitjoin").toggle()
end, "Split/Join block", { noremap = true })

-- Mini.align
map("n", "<leader>a]", function()
  require("mini.align").align_with_mapping({ direction = "left" })
end, "Align left", { noremap = true })
map("n", "<leader>a[", function()
  require("mini.align").align_with_mapping({ direction = "right" })
end, "Align right", { noremap = true })
map("v", "<leader>a", function()
  require("mini.align").align()
end, "Align selection", { noremap = true })

-- Mini.jump / Mini.jump2d
map("n", "f", function()
  require("mini.jump2d").jump()
end, "Jump to char", { noremap = true })
map("n", "F", function()
  require("mini.jump2d").jump({ direction = "backward" })
end, "Jump backward", { noremap = true })
map("n", "<leader>jj", function()
  require("mini.jump2d").start()
end, "Jump2d start", { noremap = true })

-- Mini.diff
map("n", "<leader>dh", function()
  require("mini.diff").toggle_overlay()
end, "Diff toggle", { noremap = true })
map("n", "<leader>ds", function()
  require("mini.diff").stage()
end, "Diff stage", { noremap = true })
map("n", "<leader>dr", function()
  require("mini.diff").reset()
end, "Diff reset", { noremap = true })
map("n", "<leader>dP", function()
  require("mini.diff").preview_hunk()
end, "Diff preview hunk", { noremap = true })
