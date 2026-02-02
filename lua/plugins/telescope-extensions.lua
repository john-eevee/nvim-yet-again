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
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "tpope/vim-repeat",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = {
      defaults = {
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- FILE FINDER - Use ripgrep for better performance
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        find_command = {
          "rg",
          "--files",
          "--hidden",           -- Include hidden files
          "--glob=!.git",        -- Exclude .git directory
          "--glob=!node_modules", -- Exclude node_modules
          "--glob=!__pycache__",  -- Exclude Python cache
          "--glob=!.venv",        -- Exclude virtual environments
          "--glob=!.dart_tool",   -- Exclude Dart build
          "--glob=!build",        -- Exclude build directories
          "--glob=!dist",         -- Exclude dist directories
          "--glob=!.idea",        -- Exclude IDE config
          "--glob=!.vscode",      -- Exclude VSCode config
        },
        -- Use ripgrep for live grep as well
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",        -- Smart case matching
          "--hidden",            -- Search hidden files
          "--glob=!.git",        -- Respect gitignore patterns
        },
      },
      pickers = {
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- FILE PICKER CONFIGURATION
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
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
          no_ignore = false,     -- Respect .gitignore
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
    end,
    keys = {
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- REGISTERS
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>sr",
        "<cmd>Telescope registers<CR>",
        mode = { "n", "v" },
        desc = "Telescope: Registers",
      },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- COMMANDS & COMMAND PALETTE
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>sc",
        "<cmd>Telescope commands<CR>",
        desc = "Telescope: Commands",
      },
      {
        "<leader>sp",
        function()
          require("telescope.builtin").builtin()
        end,
        desc = "Telescope: Command Palette (Builtin)",
      },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- HELP TAGS
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>sh",
        "<cmd>Telescope help_tags<CR>",
        desc = "Telescope: Help Tags",
      },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- KEYMAPS
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>sk",
        "<cmd>Telescope keymaps<CR>",
        desc = "Telescope: Keymaps",
      },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- SEARCH HISTORY
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>s/",
        "<cmd>Telescope search_history<CR>",
        desc = "Telescope: Search History",
      },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- COMMAND HISTORY
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>s:",
        "<cmd>Telescope command_history<CR>",
        desc = "Telescope: Command History",
      },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- HIGHLIGHTS (Colorscheme colors)
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>sch",
        "<cmd>Telescope highlights<CR>",
        desc = "Telescope: Highlights",
      },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- QUICKFIX & LOCLIST
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>sq",
        "<cmd>Telescope quickfix<CR>",
        desc = "Telescope: Quickfix",
      },
      {
        "<leader>sl",
        "<cmd>Telescope loclist<CR>",
        desc = "Telescope: Loclist",
      },
    },
  },
}
