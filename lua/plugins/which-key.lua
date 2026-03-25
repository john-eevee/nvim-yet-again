return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- CTRL+ALT GROUPS
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      { "<C-A-a>", group = "Alt Commands" },
      { "<C-A-c>", group = "Colors/Check" },
      { "<C-A-d>", group = "Database/Diagnostics" },
      { "<C-A-e>", desc = "Explorer (Oil)" },
      { "<C-A-g>", group = "Git" },
      { "<C-A-h>", group = "Harpoon" },
      { "<C-A-j>", desc = "Jump2d" },
      { "<C-A-k>", desc = "Keymaps" },
      { "<C-A-l>", group = "Format/Location" },
      { "<C-A-m>", group = "Mise/Mark" },
      { "<C-A-o>", group = "Other/Output" },
      { "<C-A-p>", desc = "Pause/Spell" },
      { "<C-A-q>", desc = "Quickfix" },
      { "<C-A-r>", group = "Relative/Replace" },
      { "<C-A-s>", group = "Split/Session" },
      { "<C-A-t>", group = "Todo/Test" },
      { "<C-A-u>", group = "Utils/Rust" },
      { "<C-A-w>", group = "Wrap/Widgets/Window" },
      { "<C-A-x>", desc = "Diff toggle" },
      { "<C-A-z>", desc = "Zen/Reset hunk" },
      { "<C-A-\\>", desc = "Zen Mode" },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- CTRL+SHIFT GROUPS
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      { "<C-S-a>", desc = "Command Palette" },
      { "<C-S-b>", desc = "Goto Declaration" },
      { "<C-S-f>", desc = "Find in Path (Live Grep)" },
      { "<C-S-n>", desc = "Find Files" },
      { "<C-S-r>", desc = "Registers" },
      { "<C-S-F10>", desc = "Run Nearest Test" },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- F-KEY BINDS (Debug & Test)
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      { "<F7>", desc = "Step Into" },
      { "<F8>", desc = "Step Over" },
      { "<F9>", desc = "Continue (Debug)" },
      { "<S-F6>", desc = "Rename (Shift+F6)" },
      { "<S-F8>", desc = "Step Out" },
      { "<S-F9>", desc = "Debug Test / Run with Args" },
      { "<S-F10>", desc = "Run File Tests" },
      { "<C-F8>", desc = "Toggle Breakpoint" },
      { "<C-F4>", desc = "Close Buffer/Window" },
      { "<C-F12>", desc = "Document Symbols" },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- ALT KEY BINDS
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      { "<A-Left>", desc = "Previous Buffer" },
      { "<A-Right>", desc = "Next Buffer" },
      { "<A-F7>", desc = "Find References" },
      { "<A-F8>", desc = "Evaluate Expression" },
      { "<A-F9>", desc = "Run to Cursor" },
      { "<A-Enter>", desc = "Code Action", mode = { "n", "v" } },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- CTRL KEY BINDS
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      { "<C-b>", desc = "Goto Definition" },
      { "<C-e>", desc = "Recent Files/Buffers" },
      { "<C-1>", desc = "Harpoon 1" },
      { "<C-2>", desc = "Harpoon 2" },
      { "<C-3>", desc = "Harpoon 3" },
      { "<C-4>", desc = "Harpoon 4" },
      { "<C-h>", desc = "Previous Buffer" },
      { "<C-l>", desc = "Next Buffer" },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- LEGACY LEADER FALLBACKS (still functional)
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>f", group = "Finder" },
      { "<leader>g", group = "Go To" },
      { "<leader>s", group = "Search" },
      { "<leader>u", group = "UI" },
      { "<leader>w", group = "Window" },
      { "<leader>r", group = "Refactor" },
      { "<leader>jj", group = "Jump" },
      { "<leader>a", group = "Align" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
  end,
}
