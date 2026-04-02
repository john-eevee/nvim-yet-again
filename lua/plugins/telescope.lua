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

        pickers
          .new({}, {
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
                  local args_str = args and args ~= "" and (" " .. args) or ""
                  local title = string.format("[mise] %s%s", selection.value.name, args_str)
                  local cwd = vim.fn.getcwd()

                  local cmd = string.format(
                    "wezterm cli spawn --cwd '%s' -- bash -c 'mise run %s%s'",
                    cwd,
                    selection.value.name,
                    args_str
                  )
                  local pane_id = vim.fn.system(cmd):gsub("%s+", "")

                  if pane_id and pane_id ~= "" then
                    vim.fn.system(string.format("wezterm cli set-tab-title --pane-id %s '%s'", pane_id, title))
                  end
                end)
              end)
              return true
            end,
          })
          :find()
      end

      vim.api.nvim_create_user_command("MiseRunTelescope", run_mise_task_telescope, { nargs = 0 })
    end,
  },
}
