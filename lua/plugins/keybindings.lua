return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- LEADER GROUPS (Mnemonic System)
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      { "<leader>a", group = "AI (Opencode)" },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code & LSP" },
      { "<leader>d", group = "Diagnostics" },
      { "<leader>D", group = "Debugging" },
      { "<leader>e", group = "Edit" },
      { "<leader>G", group = "Git (Gitsigns)" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>m", group = "Mise" },
      { "<leader>o", group = "Other" },
      { "<leader>s", group = "Search (Telescope)" },
      { "<leader>t", group = "Toggles" },
      { "<leader>w", group = "Window" },

      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      -- F-KEY BINDS (Debug & Test)
      -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      { "<F2>", desc = "Next Error" }, -- new
      { "<F7>", desc = "Step Into" },
      { "<F8>", desc = "Step Over" },
      { "<F9>", desc = "Continue (Debug)" },
      { "<S-F2>", desc = "Prev Error" }, -- new
      { "<S-F6>", desc = "Rename (Shift+F6)" },
      { "<S-F8>", desc = "Step Out" },
      { "<S-F9>", desc = "Run File Tests (Neotest)" }, -- changed from Debug/Run with Args (now neotest only)
      { "<S-F10>", desc = "Run File Tests" },
      { "<C-F4>", desc = "Close Buffer/Window" },
      { "<C-F8>", desc = "Toggle Breakpoint" },
      { "<C-F12>", desc = "Document Symbols" },
      { "<A-F12>", desc = "Toggle Terminal" }, -- new

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
      { "<C-d>", desc = "Duplicate Line" }, -- new
      { "<C-e>", desc = "Recent Files/Buffers" },
      { "<C-g>", desc = "Go to Line" }, -- new
      { "<C-y>", desc = "Delete Line" }, -- new
      { "<C-w>", desc = "Extend Selection (Treesitter)" }, -- changed from window prefix
      { "<C-/>", desc = "Comment Line" }, -- new
      { "<C-1>", desc = "Harpoon 1" },
      { "<C-2>", desc = "Harpoon 2" },
      { "<C-3>", desc = "Harpoon 3" },
      { "<C-4>", desc = "Harpoon 4" },
      { "<C-h>", desc = "Previous Buffer" },
      { "<C-l>", desc = "Next Buffer" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
  end,
}
