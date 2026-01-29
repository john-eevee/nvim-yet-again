-- ╔══════════════════════════════════════════════════════════════╗
-- ║         LAZY.NVIM - PLUGIN MANAGER BOOTSTRAP                 ║
-- ║     Fast, modern plugin management with lazy loading          ║
-- ╚══════════════════════════════════════════════════════════════╝

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- PLUGIN SPECIFICATIONS & CONFIGURATION
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local plugins = {
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- UI & THEME
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("plugins.ui.catppuccin")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.ui.lualine")
    end,
  },

  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- EDITOR ENHANCEMENTS
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "numToStr/comment.nvim",
    keys = { "gc", "gb" },
    config = function()
      require("plugins.editor.comment")
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.editor.autopairs")
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.editor.which-key")
    end,
  },

  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- TREESITTER - SYNTAX & PARSING
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main"
      },
    },
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- TELESCOPE - FUZZY FINDER & PICKER
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>ff", mode = "n" },
      { "<leader>fg", mode = "n" },
      { "<leader>fb", mode = "n" },
      { "<leader>fh", mode = "n" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.telescope")
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    lazy = true,
  },

  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- LSP - LANGUAGE SERVER PROTOCOL
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "mfussenegger/nvim-jdtls",
    },
    config = function()
      require("lsp.setup")
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function()
      require("plugins.lsp.mason")
    end,
  },

  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- JAVA DEVELOPMENT SUPPORT
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      require("plugins.java")
    end,
  },

  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- COMPLETION - AUTOCOMPLETION ENGINE
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      require("plugins.completion")
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("plugins.snippets")
    end,
  },

  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- JUMP & MOTION - ENHANCED MOVEMENT
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "ggandor/leap.nvim",
    keys = { "s", "S" },
    config = function()
      require("plugins.motion.leap")
    end,
  },

  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- PROJECT MANAGEMENT
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "DrKJeff16/project.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.project")
    end,
  },

  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- PROJECT ROOTER - AUTO CD TO PROJECT ROOT
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "airblade/vim-rooter",
    event = "VeryLazy",
    config = function()
      require("plugins.rooter")
    end,
  },

  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- FILE EXPLORER - OIL
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = { "<leader>-" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.oil")
    end,
  },

  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- GIT INTEGRATION
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "GBrowse" },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    config = function()
      require("plugins.git.gitsigns")
    end,
  },

  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- ADDITIONAL TOOLS & ENHANCEMENTS
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        patterns = {
          default = {
            "class",
            "function",
            "method",
            "block",
            "if",
            "while",
            "for",
            "with",
            "try",
          },
        },
      })
    end,
  },

  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      require("plugins.mini")
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.todo_comments")
    end,
  },

  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  -- FORMATTING & CODE QUALITY
  -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  {
    "mfussenegger/nvim-lint",
    event = "BufReadPost",
    config = function()
      -- plugin exposes global `lint` module
      -- no additional setup required here; configured in `plugins/java.lua`
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = "ConformInfo",
    config = function()
      require("plugins.conform")
    end,
  },

  {
    "nickjvandyke/opencode.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.opencode")
    end
  }
}

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LAZY.NVIM SETUP
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

require("lazy").setup(plugins, {
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
