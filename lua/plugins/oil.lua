-- ╔══════════════════════════════════════════════════════════════╗
-- ║         OIL.NVIM - FILE EXPLORER & OPERATIONS               ║
-- ║     Edit your filesystem like a regular Neovim buffer        ║
-- ╚══════════════════════════════════════════════════════════════╝

require("oil").setup({
  -- Oil will take over directory buffers (e.g. `vim .` or `:e .`)
  default_file_explorer = true,
  -- Restore the cursor in the directory you came from
  restore_win_pos = true,
  skip_confirm_for_simple_edits = true,
  -- Keymaps in oil buffer
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = true,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = false,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return name == ".." or name == ".git"
    end,
    sort = {
      { "type", "asc" },
      { "name", "asc" },
    },
  },
  -- Optional columns to be rendered in the order of appearance
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },
  -- Constrain the cursor to the editable parts of the oil buffer
  -- Set to `false` to disable, or create a custom function
  constrain_cursor_to_editable = true,
  -- Set to true to watch the filesystem for changes and reload oil
  watch_for_changes = false,
  -- Timeout duration (in ms) that oil will wait for the filesystem to change before reloading
  fs_edit_timeout = 1500,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- KEYBINDINGS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.keymap.set("n", "<leader>-", "<cmd>Oil .<CR>", { desc = "Oil: Open current directory" })
