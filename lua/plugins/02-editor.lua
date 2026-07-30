return {
  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        version = "*",
      },
    },
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg", "--color=never", "--no-heading", "--with-filename",
          "--line-number", "--column", "--smart-case",
        },
        find_command = { "rg", "--files" },
        -- Esc in insert mode closes directly (no intermediate normal mode)
        mappings = {
          i = {
            ["<Esc>"] = require("telescope.actions").close,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = {
            "rg", "--files", "--hidden",
            "--glob=!.git", "--glob=!node_modules", "--glob=!__pycache__",
            "--glob=!.venv", "--glob=!build", "--glob=!dist",
          },
          hidden = true,
        },
        buffers = {
          sort_lastused = true,
          ignore_current_buffer = true,
          previewer = false,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        frecency = {
          matcher = "fuzzy", -- use fzf-native fuzzy matching
          show_scores = false,
          show_unindexed = true,
          ignore_patterns = {
            "*.git/*", "*/node_modules/*", "*/__pycache__/*",
            "*.venv/*", "*/build/*", "*/dist/*",
          },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "frecency")
    end,
  },

  -- Oil (file explorer)
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      columns = { "icon" },
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, _)
          return vim.startswith(name, ".") and name ~= ".."
        end,
      },
      window = {
        max_width = 80,
        min_width = 20,
      },
    },
  },

  -- Conform (formatting)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        rust = { "rustfmt" },
        go = { "goimports", "golines" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        sql = { "sqlfluff" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },

  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- Flash (rapid navigation)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
    },
  },

  -- Grug-far (search & replace)
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = { headerMaxWidth = 80 },
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo" },
    },
  },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = "catppuccin",
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", icon = "" } },
          lualine_b = { { "branch", icon = "󰘬" } },
          lualine_c = {},
          lualine_x = { "diagnostics" },
          lualine_y = { "filetype" },
          lualine_z = { "location" },
        },
      }
    end,
  },
}
