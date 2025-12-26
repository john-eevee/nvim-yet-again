-- ╔══════════════════════════════════════════════════════════════╗
-- ║           NEOVIM CONFIGURATION - TERMINAL CENTRIC            ║
-- ║              Modern, Performant, Well-Organized              ║
-- ╚══════════════════════════════════════════════════════════════╝

-- Bootstrap: Load configuration modules
require("config.settings")      -- Editor settings and global options
require("config.keymaps")       -- Leader key and core keymaps
require("config.keymap_extended") -- Extended keymaps and shortcuts
require("config.commands")      -- Custom user commands
require("config.mise")          -- Mise-en-place environment setup
require("config.lazy")          -- Plugin manager setup (lazy.nvim)
require("config.autocmds")      -- Autocommands and event handlers
require("config.shell")         -- Shell integration (FISH)
require("config.ui")            -- Advanced UI and highlight configuration
