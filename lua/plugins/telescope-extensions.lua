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

local theme = "ivy"
local buf_toggle = 1
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
        theme = theme,
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
          theme = theme,
        },
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- LIVE GREP CONFIGURATION
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        live_grep = {
          -- ripgrep already configured in defaults above
          additional_args = function()
            return { "--smart-case" }
          end,
          theme = theme,
        },
      },
      extensions = {
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- REGISTERS EXTENSION
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        registers = {
          show_empty = false,
          theme = theme,
        },
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        -- FZF EXTENSION - Fast fuzzy matching
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
          theme = theme,
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
        "<leader>srg",
        "<cmd>Telescope registers<CR>",
        mode = { "n", "v" },
        desc = "Telescope: Registers",
      },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- FIND FILES & LIVE GREP
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>ff",
        "<cmd>Telescope find_files<CR>",
        desc = "Telescope: Find Files",
      },
      {
        "<leader>fg",
        "<cmd>Telescope live_grep<CR>",
        desc = "Telescope: Live Grep",
      },
      {
        "<leader>fb",
        "<cmd>Telescope buffers<CR>",
        desc = "Telescope: Buffers",
      },
      {
        "<leader>bb",
        function()
          if buf_toggle == 1 then
            vim.cmd("bprev")
            buf_toggle = 0
          else
            vim.cmd("bnext")
            buf_toggle = 1
          end
        end,
        desc = "Buffer: Cycle",
      },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- COMMANDS & COMMAND PALETTE
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>fc",
        "<cmd>Telescope commands<CR>",
        desc = "Telescope: Commands",
      },
      {
        "<leader>fp",
        function()
          require("telescope.builtin").builtin()
        end,
        desc = "Telescope: Command Palette (Builtin)",
      },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- HELP TAGS
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>fh",
        "<cmd>Telescope help_tags<CR>",
        desc = "Telescope: Help Tags",
      },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- KEYMAPS
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>fk",
        "<cmd>Telescope keymaps<CR>",
        desc = "Telescope: Keymaps",
      },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- SEARCH HISTORY
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>f/",
        "<cmd>Telescope search_history<CR>",
        desc = "Telescope: Search History",
      },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- COMMAND HISTORY
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      {
        "<leader>f:",
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
      {
        "<leader>gR",
        "<cmd>Telescope lsp_references<CR>",
        desc = "Telescope: LSP References",
      },
      {
        "<leader>go",
        "<cmd>Telescope lsp_document_symbols<CR>",
        desc = "Telescope: LSP Document Symbols",
      },
      {
        "<leader>gO",
        "<cmd>Telescope lsp_workspace_symbols<CR>",
        desc = "Telescope: LSP Workspace Symbols",
      },
      {
        "<leader>gx",
        "<cmd>Telescope diagnostics<CR>",
        desc = "Telescope: Diagnostics",
      },
      {
        "<leader>gI",
        "<cmd>Telescope lsp_implementations<CR>",
        desc = "Telescope: Implementations",
      },

      {
        "<leader>gd",
        "<cmd>Telescope definitions<CR>",
        desc = "Telescope: Definitions",
      },

      {
        "<leader>gT",
        "<cmd>Telescope lsp_type_definitions<CR>",
        desc = "Telescope: Type Definitions",
      },
    },
  },
}
