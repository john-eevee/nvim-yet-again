-- ╔══════════════════════════════════════════════════════════════╗
-- ║        GITSIGNS.NVIM - GIT DIFF & STATUS MARKS               ║
-- ║     Show git changes in the sign column with hunks           ║
-- ╚══════════════════════════════════════════════════════════════╝

require("gitsigns").setup({
  signs = {
    add = { text = "▕", hl = "GitSignsAdd" },
    change = { text = "▕", hl = "GitSignsChange" },
    delete = { text = "▕", hl = "GitSignsDelete" },
    topdelete = { text = "▔", hl = "GitSignsDelete" },
    changedelete = { text = "▕", hl = "GitSignsChange" },
    untracked = { text = "▕", hl = "GitSignsAdd" },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 100,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    border = "rounded",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end, { desc = "Git: Next hunk" })
    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end, { desc = "Git: Prev hunk" })

    -- Actions
    map("n", "<leader>gh", gs.preview_hunk, { desc = "Git: Preview hunk" })
    map("n", "<leader>gs", gs.stage_hunk, { desc = "Git: Stage hunk" })
    map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Git: Undo stage" })
    map("n", "<leader>gr", gs.reset_hunk, { desc = "Git: Reset hunk" })
    map("v", "<leader>gs", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Git: Stage selection" })
    map("v", "<leader>gr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Git: Reset selection" })

    map("n", "<leader>gS", gs.stage_buffer, { desc = "Git: Stage buffer" })
    map("n", "<leader>gR", gs.reset_buffer, { desc = "Git: Reset buffer" })
    map("n", "<leader>gb", function()
      gs.blame_line({ full = true })
    end, { desc = "Git: Blame line" })
    map("n", "<leader>gt", gs.toggle_current_line_blame, { desc = "Git: Toggle blame" })
    map("n", "<leader>gd", gs.diffthis, { desc = "Git: Diff this" })
  end,
})
