-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- NvimTree - Sidebar File Explorer
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Provides a traditional sidebar file tree for project navigation
--
-- Features:
-- • Persistent sidebar tree view
-- • Automatic sync with opened buffers
-- • Git status indicators
-- • File icons with nvim-web-devicons
-- • Filtering and searching capabilities
--
-- Keybindings:
-- Alt+1              Toggle nvim-tree
-- a                  Create new file/directory
-- d                  Delete file/directory
-- r                  Rename file/directory
-- x                  Cut file
-- c                  Copy file
-- p                  Paste file
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({
        -- Automatically sync nvim-tree to the buffer when opened
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
              enable = true,
              picker = 'default',
              chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
              exclude = {
                filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
                buftype = { 'nofile', 'terminal', 'help' },
              },
            },
          },
        },
        view = {
          width = 30,
          side = 'right',
          preserve_window_proportions = false,
          number = false,
          relativenumber = false,
          signcolumn = 'yes',
          float = {
            enable = false,
            quit_on_focus_loss = true,
            open_win_config = {
              relative = 'editor',
              border = 'rounded',
              width = 30,
              height = 30,
              row = 1,
              col = 1,
            },
          },
        },
        -- Sync the tree with the currently opened file
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
          ignore_list = {},
        },
        diagnostics = {
          enable = true,
          show_on_dirs = false,
          debounce_delay = 50,
          custom_icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
          },
        },
        filters = {
          dotfiles = false,
          custom = { '.DS_Store', '*.swp', '*.swo', '*.git' },
          exclude = {},
        },
        trash = {
          cmd = 'trash',
          require_confirm = true,
        },
        git = {
          enable = true,
          ignore = false,
          timeout = 400,
        },
        renderer = {
          add_trailing = false,
          group_empty = false,
          highlight_git = false,
          full_name = false,
          root_folder_label = false,
          indent_width = 2,
          indent_markers = {
            enable = false,
            inline = false,
            icons = {
              corner = '└',
              edge = '│',
              item = '├',
              bottom = '─',
              none = ' ',
            },
          },
          icons = {
            webdev_colors = true,
            git_placement = 'before',
            padding = ' ',
            symlink_arrow = ' ➛ ',
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = '',
              symlink = '',
              bookmark = '󰆤',
              folder = {
                arrow_closed = '',
                arrow_open = '',
                default = '',
                open = '',
                empty = '',
                empty_open = '',
                symlink = '',
                symlink_open = '',
              },
              git = {
                unstaged = '✗',
                staged = '✓',
                unmerged = '',
                renamed = '➜',
                untracked = '★',
                deleted = '',
                ignored = '◌',
              },
            },
          },
          special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
          symlink_destination = true,
        },
        on_attach = function(bufnr)
          local api = require 'nvim-tree.api'
          
          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- Default mappings
          api.config.mappings.default_on_attach(bufnr)

          -- Custom keymaps can be added here if needed
        end,
      })

      -- Keybinding for Alt+1 to toggle nvim-tree
      local keymap = vim.keymap.set
      keymap('n', '<M-1>', '<cmd>NvimTreeToggle<CR>', { noremap = true, silent = true, desc = 'Toggle file explorer tree' })
    end,
  },
}
