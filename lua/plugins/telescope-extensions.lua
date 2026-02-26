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
        defaults = {
          theme = theme,
        },
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
        -- BUFFERS CONFIGURATION
        -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        buffers = {
          theme = theme,
          initial_mode = "normal",
          mappings = {
            i = {
              ["<c-d>"] = require("telescope.actions").delete_buffer,
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

      local pickers = require("telescope.pickers")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local function run_mise_task_telescope()
        local task_list = vim.fn.systemlist("mise tasks --json 2>/dev/null")
        if vim.v.shell_error ~= 0 or #task_list == 0 then
          vim.notify("No mise tasks found", vim.log.levels.WARN)
          return
        end

        local tasks = {}
        for _, line in ipairs(task_list) do
          local decoded = vim.json.decode(line)
          if decoded and decoded.name then
            table.insert(tasks, decoded)
          end
        end

        pickers.new({}, {
          prompt_title = "Mise Tasks",
          finder = require("telescope.finders").new_table({
            results = tasks,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry.name .. (entry.description and (" - " .. entry.description) or ""),
                ordinal = entry.name,
              }
            end,
          }),
          sorter = require("telescope.sorters").get_fuzzy_file(),
          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)

              vim.ui.input({ prompt = "Arguments (optional): " }, function(args)
                local cmd = string.format(
                  "tmux split-window -h -c '%s' 'mise run %s%s'",
                  vim.fn.getcwd(),
                  selection.value.name,
                  args and args ~= "" and (" " .. args) or ""
                )
                vim.fn.system(cmd)
              end)
            end)
            return true
          end,
        }):find()
      end

      vim.api.nvim_create_user_command("MiseRunTelescope", run_mise_task_telescope, { nargs = 0 })
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
