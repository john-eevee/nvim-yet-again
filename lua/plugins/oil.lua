-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Oil.nvim - File Explorer as a Buffer
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Oil.nvim lets you edit your filesystem like a normal Neovim buffer
--
-- Features:
-- • Edit files and directories like a buffer
-- • Intuitive operations (copy, move, delete, create)
-- • Close with 'q' and automatically save
-- • Preview files before opening
-- • Support for git status, icons, and more
--
-- Keybindings:
-- <leader>-      Toggle oil file explorer
-- g?             Show help in oil
-- -              Go to parent directory
-- gd             Show file details
-- gs             Show git status
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

return {
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = false,
      columns = {
        "icon",
      },
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      window = {
        max_width = 80,
        min_width = 20,
        width_delta = 17,
        max_height = 0,
        min_height = 5,
        height_delta = 5,
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
        -- This is the config used for vertical splits and floating windows
        preview_split = "right",
        -- Height of preview window
        preview_height = 0,
        -- Width of preview window
        preview_width = 0,
      },
      -- Oil will automatically call this when the user opens oil
      on_mount = nil,
      -- Restore the previous view when leaving an oil buffer
      restore_win_options = true,
      -- Skip the confirmation popup for simple operations. Which operations?
      -- * copy (false by default)
      -- * move (false by default)
      -- * delete (false by default)
      -- * trash (true by default)
      skip_confirm_for_simple_edits = false,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = false,
        -- This function is called every time oil renders the view.
        -- It should sort the given list of files and directories
        -- by some criteria. See :help oil-columns to see what fields are available
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        is_always_hidden = function(name, bufnr)
          return false
        end,
        sort = {
          -- sort order can be "asc" or "desc"
          -- see :help oil-sort for more details.
          { "type", "asc" },
          { "name", "asc" },
        },
      },
      -- Extra arguments to pass to SCP when moving/copying files over SSH
      extra_scp_args = {},
      -- EXPERIMENTAL: Maybe this API will be removed
      git = {
        add = function(path)
          return false
        end,
        mv = function(src_path, dest_path)
          return false
        end,
        rm = function(path)
          return false
        end,
      },
      -- Configuration for the actions floating window
      actions = {
        max_height = 0,
        min_height = { line_count = 1, height_ratio = 0.4 },
        width_delta = 1,
        margin = { top = 0, bottom = 2 },
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>-",
        "<cmd>Oil .<CR>",
        desc = "Oil: Toggle file explorer",
      },
    },
  },
}
