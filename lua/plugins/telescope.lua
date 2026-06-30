-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Telescope Extensions - Registers, Commands, and More
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- This file extends Telescope with useful extensions for searching registers,
-- commands, command palette, and more.
--
-- Extensions added:
-- 1. telescope-registers - Browse and paste from registers easily
-- 2. telescope-command-palette - Command palette UI (Cmd+Shift+P style)
-- 3. telescope.builtin - Built-in pickers (commands, help_tags, etc.)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    lazy = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "tpope/vim-repeat",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "kkharji/sqlite.lua",
    },
    opts = {
      defaults = {
        history = {
          path = vim.fn.stdpath("cache") .. "/history.sqlite3",
          limit = 1000,
        },
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- FILE FINDER - Use ripgrep for better performance
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        find_command = {
          "rg",
          "--files",
        },
        -- Use ripgrep for live grep as well
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case", -- Smart case matching
        },
      },
      pickers = {
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- FILE PICKER CONFIGURATION
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        defaults = {},
        find_files = {
          -- Use ripgrep for finding files
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob=!.git",
            "--glob=!node_modules",
            "--glob=!__pycache__",
            "--glob=!.venv",
            "--glob=!.dart_tool",
            "--glob=!build",
            "--glob=!dist",
            "--glob=!.idea",
            "--glob=!.vscode",
          },
          hidden = true,
          no_ignore = false, -- Respect .gitignore
        },
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- BUFFERS CONFIGURATION
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        buffers = {
          initial_mode = "normal",
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            },
          },
          sort_lastused = true,
          show_all_buffers = true,
          ignore_current_buffer = true,
          previewer = false,
          layout_strategy = "vertical",
          format_buffer_name = function(buffer_path, bufnr)
            local filename = vim.fn.fnamemodify(buffer_path, ":t")
            local dirname = vim.fn.fnamemodify(buffer_path, ":h")
            if dirname == "." then
              return filename
            end
            return string.format("%s (%s)", filename, dirname)
          end,
        },
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- LIVE GREP CONFIGURATION
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        live_grep = {
          -- ripgrep already configured in defaults above
          additional_args = function()
            return { "--smart-case" }
          end,
        },
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- DIAGNOSTICS PICKER
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        diagnostics = {
          theme = "ivy",
          previewer = false,
          wrap_results = true,
          sorting_strategy = "ascending",
        },
      },
      extensions = {
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- REGISTERS EXTENSION
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        registers = {
          show_empty = false,
        },
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- FZF EXTENSION - Fast fuzzy matching
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      -- Load extensions
      pcall(telescope.load_extension, "registers")
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "notify")
      pcall(telescope.load_extension, "live_grep_args")

    end,
  },
}
